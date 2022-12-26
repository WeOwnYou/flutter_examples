import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart' show Project, Task;
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/home/bloc/home_bloc.dart';
import 'package:vedita_learning2/ui/home/widgets/widgets.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget implements AutoRouteWrapper{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final projectsExist = context.select<MainBloc, int>(
          (bloc) => bloc.state.projects?.length ?? 0,
        ) !=
        0;
    final tasks =
        context.select<MainBloc, List<Task>?>((bloc) => bloc.state.tasks);
    final tasksExist = (tasks?.length ?? 0) != 0;
    const sliversIfProjectsExist = [
      _BuildCategoryCards(),
      _BuildSlidingProject(),
      _BuildSlidingDotes(),
    ];
    final sliversIfTasksExist = [
      const _BuildTaskTitleWidget(),
      _BuildTaskList(tasks: tasks),
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _BuildAppBar(),
          const _BuildNameLabel(),
          ...projectsExist ? sliversIfProjectsExist : [],
          ...tasksExist ? sliversIfTasksExist : [],
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (ctx) => HomeBloc(),
      child: this,
    );
  }
}

class _BuildAppBar extends StatelessWidget {
  const _BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addEvent = context.read<MainBloc>().add;
    final projectNameController = TextEditingController();
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.textAndIconColor,
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          addEvent(RemoveProject());
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: AppColors.textAndIconColor,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              BuildAddProjectSnackBar(
                key: key,
                projectNameController: projectNameController,
                addEvent: addEvent,
                context: context,
              ),
            );
          },
        )
      ],
    );
  }
}

class _BuildNameLabel extends StatelessWidget {
  const _BuildNameLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final username = context.select<MainBloc, String>((bloc) => bloc.username);
    return SliverPadding(
      padding: EdgeInsets.only(top: 55 / 1337 * height, left: 50 / 619 * width),
      sliver: SliverToBoxAdapter(
        child: ListTile(
          title: Text(
            'Hello, $username!',
            style: const TextStyle(
              color: AppColors.textAndIconColor,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Have a nice day.',
            style: TextStyle(
              color: AppColors.textAndIconColor.withOpacity(0.54),
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildCategoryCards extends StatelessWidget {
  const _BuildCategoryCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final categories = ['My tasks', 'In-progress', 'Completed'];
    final selectedTitle = context.select<HomeBloc, Categories>(
      (bloc) => bloc.state.category,
    );
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: 0.015 * height,
      ),
      sliver: SliverToBoxAdapter(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10 / 1337 * height,
              childAspectRatio: 156 / 70,
            ),
            itemBuilder: (context, index) {
              return CategoryCardWidget<ChangeCategory>(
                title: categories[index],
                isSelected: index  == selectedTitle.index,
                addEventFunc: context.read<HomeBloc>().add,
                changeCategoryEvent: ChangeCategory(Categories.values[index]),
                selectedTextColor: AppColors.textAndIconColor,
                unselectedTextColor: AppColors.textAndIconColor,
                unselectedBackgroundColor: AppColors.unselectedCardColor,
                selectedBackgroundColor: Colors.white,
              );
            },
            itemCount: categories.length,
          ),
        ),
      ),
    );
  }
}

class _BuildSlidingProject extends StatelessWidget {
  const _BuildSlidingProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final scrollController = context
        .read<HomeBloc>()
        .getPageScrollController(365 * MediaQuery.of(context).size.width / 619);
    final projects =
        context.select<MainBloc, List<Project>?>((bloc) => bloc.state.projects);

    return SliverPadding(
      padding: EdgeInsets.only(top: 32 / 1337 * height),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 341 / 619 * width,
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(left: 50 / 619 * width),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final title = projects![index].projectTitle;
              return ProjectTile(
                projectName: 'Project $index',
                title: title,
                dateTime: DateTime.now(),
                rightPadding: 24 / 619 * width,
                projectIndex: index,
              );
            },
            itemCount: projects?.length ?? 0,
          ),
        ),
      ),
    );
  }
}

//TODO: доделать?
class _BuildSlidingDotes extends StatelessWidget {
  const _BuildSlidingDotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final projectsLength = context
        .select<MainBloc, int>((bloc) => bloc.state.projects?.length ?? 0);
    final dotesIndex = context
        .select<HomeBloc, int>((bloc) => bloc.state.selectedDotIndex ?? 0);
    return SliverPadding(
      padding: EdgeInsets.only(top: 29 / 1337 * height),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              dotesIndex,
              (index) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.greyColor,
                  ),
                );
              },
            ),
            Container(
              width: 42,
              height: 10,
              decoration: BoxDecoration(
                gradient: projectsLength == 0 ? null : AppColors.gradient,
                borderRadius: BorderRadius.circular(78),
              ),
            ),
            ...List.generate(
              (projectsLength - dotesIndex - 1) <= 0
                  ? 0
                  : (projectsLength - dotesIndex - 1),
              (index) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.greyColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildTaskTitleWidget extends StatelessWidget {
  const _BuildTaskTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: EdgeInsets.only(
        left: 0.081 * width,
        top: 0.036 * height,
        bottom: 0.027 * height,
      ),
      sliver: const SliverToBoxAdapter(
        child: Text(
          'Progress',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _BuildTaskList extends StatelessWidget {
  final List<Task>? tasks;
  const _BuildTaskList({
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
