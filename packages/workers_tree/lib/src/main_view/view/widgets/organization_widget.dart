import 'package:flutter/material.dart';
import 'package:workers_tree/src/main_view/entity/department.dart';

class OrganizationWidget extends StatelessWidget {
  final Organization organization;
  final void Function(String name) onAddDepartment;
  final EdgeInsets margin;
  final double height;
  const OrganizationWidget({
    super.key,
    required this.organization,
    required this.onAddDepartment,
    required this.margin,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          _addDepartmentSnackBar(context,
              organizationName: organization.name,
              onAddDepartment: onAddDepartment,),
        );
      },
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Text(
            organization.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

SnackBar _addDepartmentSnackBar(
  BuildContext context, {
  required String organizationName,
  required void Function(String name) onAddDepartment,
}) {
  final controller = TextEditingController();
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(organizationName),
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
                  // child:
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Название депрартамента',
                      suffix: IconButton(
                        onPressed: () {
                          if(controller.text.trim().isEmpty) return;
                          onAddDepartment(controller.text);
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
        )
      ],
    ),
  );
}
