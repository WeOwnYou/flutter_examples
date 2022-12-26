import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/navigation/router.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/to_do_list/bloc/to_do_list_bloc.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

class ToDoListHeader extends StatelessWidget {
  const ToDoListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(),
        _BuildHeader(),
        _BuildScrollingDatesWidget(),
      ],
    );
  }
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final month = context.read<ToDoListBloc>().state.month;
    final year = context.read<ToDoListBloc>().state.year;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.072, vertical: 20),
      child: SizedBox(
        height: height * 0.052,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                '$month, $year',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 100),
              ),
            ),
            AspectRatio(
              aspectRatio: 171 / 70,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(75),
                  ),
                  gradient: AppColors.gradient,
                ),
                child: MaterialButton(
                  height: double.infinity,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          'Add task',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    AppRouter.instance().push(
                      AddTaskRoute(
                        hiveRepository: context.read<MainBloc>().hiveRepository,
                        selectedDate: context.read<ToDoListBloc>().state.date,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildScrollingDatesWidget extends StatelessWidget {
  const _BuildScrollingDatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final scrollController =
        context.read<ToDoListBloc>().scrollingDatesController;
    final animateToCurrentDate =
        context.read<ToDoListBloc>().animateDatesToCurrent;
    final pickedDate = context.select<ToDoListBloc, DateTime>((bloc) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => animateToCurrentDate(context),
      );
      return bloc.state.date;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: height * 123 / 1337,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: DateTime.now().numberOfDaysInMonth(),
          itemExtent: width * 85 / 619,
          itemBuilder: (context, index) {
            index++;
            return GestureDetector(
              onTap: () {
                context.read<ToDoListBloc>().add(
                      ChangeDate(
                        pickedDate.add(Duration(days: index - pickedDate.day)),
                      ),
                    );
              },
              child: DateWidget(index),
            );
          },
        ),
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final int index;
  const DateWidget(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDate =
        context.select<ToDoListBloc, DateTime>((bloc) => bloc.state.date);
    final currentDateTime =
        DateTime(DateTime.now().year, DateTime.now().month, index);
    return DecoratedBox(
      decoration: index == selectedDate.day
          ? ShapeDecoration(
              gradient: AppColors.datesFieldGradient,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                currentDateTime.getWeekdayName(),
                style: index == selectedDate.day
                    ? TextStyle(
                        fontWeight: FontWeight.w500,
                        foreground: Paint()..shader = AppColors.textGradient,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
              ),
              Text(
                currentDateTime.day.toString(),
                style: index == selectedDate.day
                    ? TextStyle(
                        foreground: Paint()..shader = AppColors.textGradient,
                        fontWeight: FontWeight.w300,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
