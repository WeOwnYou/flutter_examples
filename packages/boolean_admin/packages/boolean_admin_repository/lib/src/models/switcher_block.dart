import 'package:equatable/equatable.dart';

enum SwitcherType { simpleSwitcher, radioSwitcher, checkboxSwitcher }

class SwitcherBlock extends Equatable {
  final String id;
  final int sortingOrderNumber;
  final String name;
  final bool simpleSwitcherState;
  final bool radioSwitcherState;
  final bool checkboxSwitcherState;
  const SwitcherBlock({
    required this.id,
    required this.name,
    required this.simpleSwitcherState,
    required this.checkboxSwitcherState,
    required this.radioSwitcherState,
    required this.sortingOrderNumber,
  });

  factory SwitcherBlock.fromMap(Map<String, dynamic> map) {
    return SwitcherBlock(
      id: map['id'] as String,
      sortingOrderNumber: map['sortingOrderNumber'] as int,
      name: map['name'] as String,
      simpleSwitcherState:
          map['simpleSwitcher'].toString().parseBool(),
      checkboxSwitcherState:
          map['checkboxSwitcher'].toString().parseBool(),
      radioSwitcherState:
          map['radioSwitcher'].toString().parseBool(),
    );
  }

  SwitcherBlock copyWith({
    String? id,
    int? sortingOrderNumber,
    String? name,
    bool? simpleSwitcherState,
    bool? radioSwitcherState,
    bool? checkboxSwitcherState,
  }) {
    return SwitcherBlock(
      id: id ?? this.id,
      name: name ?? this.name,
      simpleSwitcherState: simpleSwitcherState ?? this.simpleSwitcherState,
      radioSwitcherState: radioSwitcherState ?? this.radioSwitcherState,
      checkboxSwitcherState: checkboxSwitcherState ?? this.checkboxSwitcherState,
      sortingOrderNumber: sortingOrderNumber ?? this.sortingOrderNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        sortingOrderNumber,
        name,
        simpleSwitcherState,
        radioSwitcherState,
        checkboxSwitcherState,
      ];
}

//There is no bool is sqflite
extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase().trim() == 'true';
  }
}
