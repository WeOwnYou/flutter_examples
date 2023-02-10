import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers_tree/src/main_view/bloc/main_bloc.dart';
import 'package:workers_tree/src/main_view/view/widgets/widgets.dart';

const _organizationMargin = EdgeInsets.symmetric(vertical: 20);
const _organizationHeight = 60.0;
const _departmentMargin = EdgeInsets.symmetric(horizontal: 10.0);

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Tree App'),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (ctx, state) {
          final departments = state.organization.departments;
          final widgetWidth = width / departments.length -
              _departmentMargin.left -
              _departmentMargin.right;
          if (departments.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MainBloc>().add(const UpdateTreeEvent());
              await Future<void>.delayed(const Duration(milliseconds: 200));
            },
            child: Stack(
              children: [
                ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    OrganizationWidget(
                      organization: state.organization,
                      onAddDepartment: (name) {
                        context
                            .read<MainBloc>()
                            .add(AddDepartmentEvent(name: name));
                      },
                      margin: _organizationMargin,
                      height: _organizationHeight,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(departments.length, (index) {
                        return Padding(
                          padding: _departmentMargin,
                          child: DepartmentWidget(
                            onDepartmentMoved: (data, id) {
                              context.read<MainBloc>().add(
                                    MoveDepartmentEvent(
                                      idToInsert: id,
                                      data: data,
                                    ),
                                  );
                            },
                            onDepartmentRemoved: (id) {
                              context.read<MainBloc>().add(
                                    RemoveDepartmentEvent(
                                      departmentId: id,
                                    ),
                                  );
                            },
                            onWorkerAdded: (name, id) {
                              context.read<MainBloc>().add(
                                    AddWorkerEvent(
                                      name: name,
                                      departmentId: id,
                                    ),
                                  );
                            },
                            onWorkerRemoved: (workerId, departmentId) {
                              context.read<MainBloc>().add(
                                    RemoveWorkerEvent(
                                      workerId: workerId,
                                      departmentId: departmentId,
                                    ),
                                  );
                            },
                            departmentWidth: widgetWidth,
                            department: departments[index],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                ...List.generate(departments.length, (index) {
                  return CustomPaint(
                    painter: ArrowPainter(
                      p1: Offset(
                        MediaQuery.of(context).size.width / 2,
                        _organizationHeight + _organizationMargin.top,
                      ),
                      p2: Offset(
                        _departmentMargin.left +
                            widgetWidth / 2 +
                            index *
                                (widgetWidth +
                                    _departmentMargin.left +
                                    _departmentMargin.right),
                        _organizationHeight +
                            _organizationMargin.bottom +
                            _organizationMargin.top,
                      ),
                    ),
                  );
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
