import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';

class BuildAddProjectSnackBar extends SnackBar {
  BuildAddProjectSnackBar({
    Key? key,
    required BuildContext context,
    required TextEditingController projectNameController,
    required void Function(AddProject addProject) addEvent,
  }) : super(
          key: key,
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'Project name',
              labelStyle: TextStyle(color: Colors.white),
            ),
            controller: projectNameController,
          ),
          action: SnackBarAction(
            label: 'Add Project',
            onPressed: () {
              addEvent(
                AddProject(
                  Project(
                    id: context.read<MainBloc>().state.projects?.length ?? 0,
                    projectTitle: projectNameController.text,
                    dateTime: DateTime.now(),
                  ),
                ),
              );
            },
          ),
        );
}
