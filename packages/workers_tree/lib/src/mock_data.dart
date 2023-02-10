const _mockDelay = Duration(milliseconds: 200);
Future<Map<String, dynamic>> organizationData() async {
  await Future<void>.delayed(_mockDelay);
  return <String, dynamic>{
    'organization_id': 0,
    'organization_name': 'Транспортный департамент',
    'organization_departments': [
      {
        'department_id': 0,
        'department_name': 'Группа управления',
        'department_workers': [
          {'worker_id': 0, 'worker_name': 'Гришина А.C.'},
          {'worker_id': 1, 'worker_name': 'Дементьева В.Н.'},
        ]
      },
      {
        'department_id': 1,
        'department_name': 'Транспортный отдел',
        'department_workers': [
          {'worker_id': 2, 'worker_name': 'Симонов К.А.'},
          {'worker_id': 3, 'worker_name': 'Мишин Е.В.'},
          {'worker_id': 4, 'worker_name': 'Фадеев Н.А.'},
        ]
      },
      {
        'department_id': 3,
        'department_name': 'Группа снабжения',
        'department_workers': [
          {'worker_id': 6, 'worker_name': 'Корнилов П.И.'},
        ]
      },
    ]
  };
}
