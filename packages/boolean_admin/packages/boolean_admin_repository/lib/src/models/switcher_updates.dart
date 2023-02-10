class SwitcherUpdates {
  final String id;
  final bool? simpleSwitcherState;
  final bool? radioSwitcherState;
  final bool? checkboxSwitcherState;
  const SwitcherUpdates({
    required this.id,
    this.simpleSwitcherState,
    this.radioSwitcherState,
    this.checkboxSwitcherState,
  });

  SwitcherUpdates copyWith({
    bool? simpleSwitcherState,
    bool? radioSwitcherState,
    bool? checkboxSwitcherState,
  }) =>
      SwitcherUpdates(
        id: id,
        simpleSwitcherState: simpleSwitcherState ?? this.simpleSwitcherState,
        radioSwitcherState: radioSwitcherState ?? this.radioSwitcherState,
        checkboxSwitcherState:
            checkboxSwitcherState ?? this.checkboxSwitcherState,
      );
  Map<String, dynamic> toUpdatesMap() {
    final updatedMap = <String, dynamic>{};
    if (simpleSwitcherState != null) {
      updatedMap.addAll(
        <String, dynamic>{'$id/simpleSwitcher': simpleSwitcherState},
      );
    }
    if (checkboxSwitcherState != null) {
      updatedMap.addAll(
        <String, dynamic>{'$id/checkboxSwitcher': checkboxSwitcherState},
      );
    }
    if (radioSwitcherState != null) {
      updatedMap.addAll(
        <String, dynamic>{'$id/radioSwitcher': radioSwitcherState},
      );
    }
    return updatedMap;
  }
}
