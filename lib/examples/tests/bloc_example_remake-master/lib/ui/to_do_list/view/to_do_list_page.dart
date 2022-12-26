import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/to_do_list/bloc/to_do_list_bloc.dart';
import 'package:vedita_learning2/ui/to_do_list/view/to_do_list_header.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

class ToDoListPage extends StatelessWidget implements AutoRouteWrapper {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDate =
        context.select<ToDoListBloc, DateTime>((bloc) => bloc.state.date);
    final tasksOnCurrentDay = context.select<MainBloc, List<Task>?>(
      (bloc) => bloc.state.tasks
          ?.where((task) => task.dateTime.isEqual(selectedDate))
          .toList(),
    );
    final tasksExist = (tasksOnCurrentDay?.length ?? 0) != 0;
    final sliversIfTaskExist = [
      const _BuildTaskTitleWidget(),
      _BuildScrollingTasksWidget(
        tasks: tasksOnCurrentDay,
      )
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _BuildHeader(),
          ...tasksExist ? sliversIfTaskExist : [],
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ToDoListBloc>(
      create: (ctx) => ToDoListBloc(),
      child: this,
    );
  }
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: Colors.black,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      elevation: 15,
      shadowColor: AppColors.shadowColor,
      actions: const [
        IconButton(
          icon: Icon(
            Icons.search,
            color: AppColors.textAndIconColor,
          ),
          onPressed: null,
        )
      ],
      flexibleSpace: const FlexibleSpaceBar(background: ToDoListHeader()),
    );
  }
}

class _BuildTaskTitleWidget extends StatelessWidget {
  const _BuildTaskTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: EdgeInsets.only(
        top: 53 / 1337 * height,
        bottom: 45 / 1337 * height,
        left: 49 / 619 * width,
      ),
      sliver: const SliverToBoxAdapter(
        child: Text(
          'Tasks',
          style: TextStyle(
            color: AppColors.textAndIconColor,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}

class _BuildScrollingTasksWidget extends StatelessWidget {
  final List<Task>? tasks;
  const _BuildScrollingTasksWidget({
    required this.tasks,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final task = tasks![index];
          final days = daysOnTaskRemaining(task);
          final hours = hoursOnTasRemaining(task);
          final minutes = minutesOnTaskRemaining(task);
          final minutesStr = minutesRemainingTitle(days, hours, minutes);
          return Dismissible(
            direction: DismissDirection.endToStart,
            child: FractionallySizedBox(
              widthFactor: 0.842,
              child: TaskCardWidget(
                task: task,
                days: days,
                hours: hours,
                minutesStr: minutesStr,
              ),
            ),
            onDismissed: (_) {
              context.read<MainBloc>().add(RemoveTask(index));
            },
            key: ValueKey<Task?>(tasks?[index]),
          );
        },
        childCount: tasks?.length ?? 0,
      ),
    );
  }
}
