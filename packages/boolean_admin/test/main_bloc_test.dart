import 'package:boolean_admin/src/main_screen/bloc/main_bloc.dart';
import 'package:boolean_admin_repository/boolean_admin_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_bloc_test.mocks.dart';


@GenerateMocks([BooleanAdminRepository])
void main() {
  late MockBooleanAdminRepository mockBooleanAdminRepository;

  setUp(() {
    mockBooleanAdminRepository = MockBooleanAdminRepository();
  });
  group('bloc test', () {
    test('main bloc test', () {
      when(mockBooleanAdminRepository.switcherBlocksStream).thenAnswer(
        (_) => Stream<List<SwitcherBlock>>.fromIterable([
          [
            const SwitcherBlock(
              id: 'id',
              name: 'name',
              simpleSwitcherState: true,
              checkboxSwitcherState: true,
              radioSwitcherState: true,
              sortingOrderNumber: 1,
            )
          ]
        ]),
      );
      final bloc = MainBloc(booleanAdminRepository: mockBooleanAdminRepository)
        ..add(
          const UpdateSwitcherBlocksEvent([
            SwitcherBlock(
              id: 'id',
              name: 'name',
              simpleSwitcherState: true,
              checkboxSwitcherState: true,
              radioSwitcherState: true,
              sortingOrderNumber: 1,
            )
          ]),
        );
      expectLater(bloc.state, const MainState(switcherBlocks: []));
      // emitsExactly()
    });
  });
}
