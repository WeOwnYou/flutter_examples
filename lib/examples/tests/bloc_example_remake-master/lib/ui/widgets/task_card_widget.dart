import 'package:flutter/material.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    Key? key,
    required this.task,
    required this.days,
    required this.hours,
    required this.minutesStr,
  }) : super(key: key);
  final Task task;
  final int days;
  final int hours;
  final String minutesStr;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12 / 1337 * height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20 / 619 * width),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(30 / 619 * width),
            child: SizedBox(
              width: 60.96,
              height: 60.96,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.gradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15 / 619 * width),
                  child: const Icon(Icons.task_outlined, color: Colors.white, size: 40,),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(
                (days == 0 ? '' : '$days days ') +
                    (hours == 0 ? '' : '$hours hours ') +
                    minutesStr,
                style: const TextStyle(
                  color: AppColors.additionalCardTextColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AppColors.greyColor),
          )
        ],
      ),
    );
  }
}
