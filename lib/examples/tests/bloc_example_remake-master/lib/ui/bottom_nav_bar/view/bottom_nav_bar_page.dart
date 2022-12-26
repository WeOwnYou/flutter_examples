import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vedita_learning2/navigation/router.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';

class BottomNavBarPage extends StatelessWidget implements AutoRouteWrapper {
  final HiveRepository hiveRepository;
  final UserRepository userRepository;
  const BottomNavBarPage({
    super.key,
    required this.hiveRepository,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        ToDoListEmptyRoute(),
        NotificationsRoute(),
        SearchEmptyRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          // currentIndex: context.select<MainBloc, int>((bloc) => bloc.state.activeTab),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index){
            if((context.read<MainBloc>().state.projects?.isEmpty??false) && index == 1) return;
            // if(index == 3) {
            //   AppRouter.instance().navigate(SearchRoute());
            // }
            tabsRouter.setActiveIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Schedule',
              icon: Icon(Icons.calendar_month),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              icon: Icon(Icons.notifications),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (ctx) => MainBloc(
        userRepository: userRepository,
        hiveRepository: hiveRepository,
      ),
      child: this,
    );
  }
}
