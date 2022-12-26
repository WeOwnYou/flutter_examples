import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

class ProjectTile extends StatelessWidget {
  final String projectName;
  final String title;
  final DateTime dateTime;
  final int projectIndex;
  final double rightPadding;
  const ProjectTile({
    Key? key,
    required this.projectName,
    required this.title,
    required this.dateTime,
    required this.rightPadding,
    required this.projectIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const oldBoxSize = 341;
    final boxSize = oldBoxSize / 619 * width;
    final selectedProject =
        context.select<MainBloc, int?>((value) => value.state.activeProjectId);
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: GestureDetector(
        child: Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
            gradient: projectIndex == selectedProject
                ? AppColors.gradient
                : AppColors.gradientWithOpacity,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(37 / oldBoxSize * boxSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle, color: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(left: 18 / oldBoxSize * boxSize),
                      child: Text(
                        projectName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 38 / oldBoxSize * boxSize),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60 / oldBoxSize * boxSize),
                  child: Text(
                    '${dateTime.getMonthName()} ${dateTime.day}, ${dateTime.year}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          context.read<MainBloc>().add(ChangeProject(projectIndex));
        },
      ),
    );
  }
}
