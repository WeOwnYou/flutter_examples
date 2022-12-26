import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/ui/add_task/bloc/add_task_bloc.dart';

class AddTaskHeader extends StatelessWidget {
  const AddTaskHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final addEvent = context.read<AddTaskBloc>().add;
    final controller = TextEditingController()
      ..text = context.select<AddTaskBloc, String>(
        (bloc) => bloc.state.dateString,
      );
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      actions: const [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: null,
        )
      ],
      flexibleSpace: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.gradient),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.only(
              top: 40,
              left: 0.05 * width,
              right: 0.05 * width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Create a Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Name',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Task name',
                    hintStyle:
                        TextStyle(color: AppColors.greyColor, fontSize: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.addTaskUnderlineHeaderGrey,
                      ),
                    ),
                  ),
                  onChanged: (newTaskName) {
                    addEvent(TaskNameChanged(newTaskName));
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Date',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextField(
                  readOnly: true,
                  controller: controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.addTaskUnderlineHeaderGrey,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<AddTaskBloc>().changeDate(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
