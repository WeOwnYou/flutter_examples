import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/ui/add_task/bloc/add_task_bloc.dart';
import 'package:vedita_learning2/ui/add_task/view/add_task_header.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

class AddTaskPage extends StatelessWidget implements AutoRouteWrapper {
  final HiveRepository hiveRepository;
  final DateTime selectedDate;
  const AddTaskPage({
    Key? key,
    required this.hiveRepository,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final addEvent = context.read<AddTaskBloc>().add;
    final selectedTitle = context.select<AddTaskBloc, String>(
      (bloc) => bloc.state.selectedCategory,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const AddTaskHeader(),
          DraggableScrollableSheet(
            initialChildSize: 864 / 1337,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * width,
                        vertical: 40 / 1337 * height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _BuildStartEndTineWidget(),
                          Padding(
                            padding: EdgeInsets.only(top: 40 / 1337 * height),
                            child: const Text(
                              'Description',
                              style:
                                  TextStyle(color: AppColors.addTaskBodyGrey),
                            ),
                          ),
                          TextField(
                            maxLines: null,
                            onChanged: (description) {
                              addEvent(DescriptionChanged(description));
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.addTaskUnderlineHeaderGrey,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30 / 1337 * height),
                            child: const Text(
                              'Category',
                              style:
                                  TextStyle(color: AppColors.addTaskBodyGrey),
                            ),
                          ),
                          SizedBox(
                            height: 245 / 1337 * height,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 27 / 1337 * height),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10 / 1337 * height,
                                childAspectRatio: 156 / 70,
                              ),
                              itemBuilder: (context, index) {
                                return CategoryCardWidget<CategoryChanged>(
                                  title: categories[index],
                                  addEventFunc: addEvent,
                                  changeCategoryEvent:
                                      CategoryChanged(categories[index]),
                                  selectedTextColor: Colors.white,
                                  unselectedBackgroundColor:
                                      AppColors.backgroundColor,
                                  isSelected:
                                      categories[index] == selectedTitle,
                                  unselectedTextColor:
                                      AppColors.textAndIconColor,
                                  selectedBackgroundGradient:
                                      AppColors.gradient,
                                );
                              },
                              itemCount: categories.length,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30 / 1337 * height),
                            child: SizedBox(
                              height: 92 / 1337 * height,
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(75),
                                  ),
                                  gradient: AppColors.gradient,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    addEvent(AddTask());
                                    AutoRouter.of(context).pop();
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Create Task',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AddTaskBloc>(
      create: (ctx) => AddTaskBloc(
        hiveRepository: hiveRepository,
        addEventFromMainBloc: context.read<MainBloc>().add,
        date: selectedDate,
      ),
      child: this,
    );
  }
}

class _BuildStartEndTineWidget extends StatelessWidget {
  const _BuildStartEndTineWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final startTimeController = TextEditingController()
      ..text = context
          .select<AddTaskBloc, String>((bloc) => bloc.state.startTimeString);
    final endTimeController = TextEditingController()
      ..text = context
          .select<AddTaskBloc, String>((bloc) => bloc.state.endTimeString);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Start Time',
              style: TextStyle(color: AppColors.addTaskBodyGrey),
            ),
            TextField(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.addTaskUnderlineHeaderGrey,
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 0.45 * width),
              ),
              controller: startTimeController,
              readOnly: true,
              onTap: () {
                context
                    .read<AddTaskBloc>()
                    .changeTime(context: context, isStartTime: true);
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'End Time',
              style: TextStyle(color: AppColors.addTaskBodyGrey),
            ),
            TextField(
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.addTaskUnderlineHeaderGrey,
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 0.45 * width),
              ),
              controller: endTimeController,
              readOnly: true,
              onTap: () {
                context
                    .read<AddTaskBloc>()
                    .changeTime(context: context, isStartTime: false);
              },
            ),
          ],
        )
      ],
    );
  }
}
