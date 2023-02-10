import 'package:flutter/material.dart';
import 'package:workers_tree/src/main_view/entity/department.dart';
import 'package:workers_tree/src/main_view/view/widgets/worker_widget.dart';

class DepartmentWidget extends StatelessWidget {
  final double departmentWidth;
  final Department department;
  final void Function(String name, int departmentId) onWorkerAdded;
  final void Function(int workerId, int departmentId) onWorkerRemoved;
  final void Function(int departmentId) onDepartmentRemoved;
  final void Function(Department data, int departmentId) onDepartmentMoved;
  const DepartmentWidget({
    Key? key,
    required this.departmentWidth,
    required this.department,
    required this.onWorkerAdded,
    required this.onWorkerRemoved,
    required this.onDepartmentRemoved,
    required this.onDepartmentMoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final departmentBox = Container(
      width: departmentWidth,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                _addWorkerOrRemoveDepartmentSnackBar(
                  context,
                  department: department,
                  onDepartmentRemoved: onDepartmentRemoved,
                  onWorkerAdded: onWorkerAdded,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                department.name,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ...List.generate(
            department.workers.length,
            (index) => WorkerWidget(
              worker: department.workers[index],
              onWorkerRemoved: () {
                onWorkerRemoved(department.workers[index].id, department.id);
              },
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return DragTarget<Department>(
      onAccept: (data) {
        onDepartmentMoved(data, department.id);
      },
      builder: (ctx, _, __) {
        return Draggable<Department>(
          data: department,
          feedback: Material(
            color: Colors.transparent,
            child: Transform.scale(
              child: departmentBox,
              scale: 1.2,
            ),
          ),
          childWhenDragging: SizedBox(
            width: departmentWidth,
          ),
          child: departmentBox,
        );
      },
    );
  }
}

SnackBar _addWorkerOrRemoveDepartmentSnackBar(
  BuildContext context, {
  required Department department,
  required void Function(int departmentId) onDepartmentRemoved,
  required void Function(String name, int departmentId) onWorkerAdded,
}) {
  final controller = TextEditingController();
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(department.name),
        Wrap(
          children: [
            IconButton(
              onPressed: () {
                onDepartmentRemoved(department.id);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (ctx) {
                    final viewInsets = EdgeInsets.fromWindowPadding(
                      WidgetsBinding.instance.window.viewInsets,
                      WidgetsBinding.instance.window.devicePixelRatio,
                    );
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: viewInsets.bottom,
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Имя сотрудника',
                          suffix: IconButton(
                            onPressed: () {
                              if (controller.text.trim().isEmpty) return;
                              onWorkerAdded(controller.text, department.id);
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    );
                  },
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.green,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
