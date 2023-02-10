import 'dart:async';
import 'dart:math';

import 'package:boolean_admin_repository/src/models/switcher_block.dart';
import 'package:boolean_admin_repository/src/models/switcher_updates.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

const _tableName = 'switcher_objects';

class BooleanAdminRepository {
  late final DatabaseReference _serverDbReference;
  late final Database _localDb;
  late final StreamController<List<SwitcherBlock>> _serverDbController;
  late final StreamController<List<SwitcherBlock>> _localDbController;
  bool _syncEnabled = true;
  final List<SwitcherUpdates> _switcherBlocksLocalUpdatesForServer = [];
  List<SwitcherUpdates> _switcherBlocksLocalUpdatesForLocal = [];

  Stream<List<SwitcherBlock>> get switcherBlocksStream async* {
    yield* _localDbController.stream;
  }

  BooleanAdminRepository() {
    _initialize();
  }

  Future<void> _initialize() async {
    _serverDbReference = FirebaseDatabase.instance.ref();
    _serverDbController = StreamController<List<SwitcherBlock>>();
    _localDbController = StreamController<List<SwitcherBlock>>();
    _localDb = await openDatabase(
      'boolean_admin.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $_tableName (
          id TEXT PRIMARY KEY NOT NULL,
          sortingOrderNumber INTEGER NOT NULL,
          name TEXT NOT NULL,
          simpleSwitcher BOOLEAN NOT NULL,
          radioSwitcher BOOLEAN NOT NULL,
          checkboxSwitcher BOOLEAN NOT NULL
          )
          ''',
        );
      },
    );

    _serverDbController.stream.listen(_updateLocalDb);
    unawaited(_uploadLocalDb());
    unawaited(_syncWithServerDb());
  }

  Future<void> _syncWithServerDb() async {
    if(!_syncEnabled) return;
    Timer(const Duration(seconds: 10), _syncWithServerDb);
    await _updateServerDb();
    await _loadServerDb();
  }

  Future<void> _uploadLocalDb() async {
    Timer(const Duration(seconds: 2), _uploadLocalDb);
    _localDbController.add(await _readFromLocalDb());
  }

  Future<void> _loadServerDb() async {
    await Future<void>.delayed(Duration(milliseconds: _randomMilliseconds));
    final switcherBlocksDynamicList =
        (await _serverDbReference.child(_tableName).once()).snapshot.value
            as Map;
    _serverDbController.add(
      _updatedBdState(switcherBlocksDynamicList.values, fromServer: true),
    );
  }

  Future<void> _updateServerDb() async {
    final updates = <String, dynamic>{};
    for (final switcherUpdate in _switcherBlocksLocalUpdatesForServer) {
      final updatedBlockMap = switcherUpdate.toUpdatesMap();
      if (updatedBlockMap.isEmpty) continue;
      updates.addAll(updatedBlockMap);
    }
    if (updates.isEmpty) return;
    _switcherBlocksLocalUpdatesForServer.clear();
    await Future<void>.delayed(Duration(milliseconds: _randomMilliseconds));
    await _serverDbReference.child(_tableName).update(updates);
  }

  Future<List<SwitcherBlock>> _readFromLocalDb() async {
    final switcherBlocksDynamicList =
        await _localDb.rawQuery('SELECT * FROM $_tableName');
    return _updatedBdState(switcherBlocksDynamicList, fromServer: false);
  }

  Future<void> _updateLocalDb(List<SwitcherBlock> switcherBlocks) async {
    await _localDb.rawQuery('DELETE FROM $_tableName');
    for (var i = 0; i < switcherBlocks.length; i++) {
      await _localDb.insert(
        _tableName,
        {
          'id': switcherBlocks[i].id,
          'sortingOrderNumber': switcherBlocks[i].sortingOrderNumber,
          'name': switcherBlocks[i].name,
          'simpleSwitcher': '${switcherBlocks[i].simpleSwitcherState}',
          'radioSwitcher': '${switcherBlocks[i].radioSwitcherState}',
          'checkboxSwitcher': '${switcherBlocks[i].checkboxSwitcherState}',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  List<SwitcherBlock> _updatedBdState(
    Iterable<dynamic>? switcherBlocksDynamicList, {
    required bool fromServer,
  }) {
    if (switcherBlocksDynamicList == null) return [];
    //updatesFromServer
    final switcherBlocksList = switcherBlocksDynamicList
        .cast<Map<dynamic, dynamic>>()
        .map(
          (dynamicMap) =>
              SwitcherBlock.fromMap(Map<String, dynamic>.from(dynamicMap)),
        )
        .toList();
    if (fromServer) {
      //localUpdatesWhileSync
      for (final localUpdate in _switcherBlocksLocalUpdatesForLocal) {
        final index = switcherBlocksList
            .indexWhere((block) => block.id == localUpdate.id);
        if (index == -1) continue;
        switcherBlocksList[index] = switcherBlocksList[index].copyWith(
          simpleSwitcherState: localUpdate.simpleSwitcherState,
          checkboxSwitcherState: localUpdate.checkboxSwitcherState,
          radioSwitcherState: localUpdate.radioSwitcherState,
        );
      }
      _switcherBlocksLocalUpdatesForLocal.clear();
    }
    return switcherBlocksList;
  }

  Future<void> updateSingleSwitcher({
    required String blockId,
    required SwitcherType type,
    required bool value,
  }) async {
    //update localDb
    final updatedFields = <String, String>{type.name: ' $value'};
    unawaited(
      _localDb.update(
        _tableName,
        updatedFields,
        where: 'id = ?',
        whereArgs: [blockId],
      ),
    );
    //markChanges
    final indexOfUpdate = _switcherBlocksLocalUpdatesForServer
        .indexWhere((updatedBlock) => updatedBlock.id == blockId);
    var switcherUpdate = (indexOfUpdate == -1)
        ? SwitcherUpdates(id: blockId)
        : _switcherBlocksLocalUpdatesForServer[indexOfUpdate];
    switch (type) {
      case SwitcherType.simpleSwitcher:
        switcherUpdate = switcherUpdate.copyWith(simpleSwitcherState: value);
        break;
      case SwitcherType.radioSwitcher:
        switcherUpdate = switcherUpdate.copyWith(radioSwitcherState: value);
        break;
      case SwitcherType.checkboxSwitcher:
        switcherUpdate = switcherUpdate.copyWith(checkboxSwitcherState: value);
        break;
    }
    if (indexOfUpdate == -1) {
      _switcherBlocksLocalUpdatesForServer.add(switcherUpdate);
      return;
    }
    _switcherBlocksLocalUpdatesForServer[indexOfUpdate] = switcherUpdate;
    _switcherBlocksLocalUpdatesForLocal =
        List.from(_switcherBlocksLocalUpdatesForServer);
  }

  Future<void> forceUpdate() async {
    _localDbController.add(await _readFromLocalDb());
  }

  void updateSyncStatus(bool enabled){
    _syncEnabled = enabled;
    if(enabled) _syncWithServerDb();
  }

  int get _randomMilliseconds => Random().nextInt(5000);

  void dispose() {
    _serverDbController.close();
    _localDbController.close();
  }
}
