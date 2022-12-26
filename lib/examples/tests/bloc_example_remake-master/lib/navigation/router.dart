import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vedita_learning2/ui/add_task/view/add_task_page.dart';
import 'package:vedita_learning2/ui/details/view/details_page.dart';
import 'package:vedita_learning2/ui/search/view/search_emoty_page.dart';
import 'package:vedita_learning2/ui/ui.dart';

part 'router.gr.dart';

abstract class Routes {
  static const authScreen = 'auth_screen';
  static const mainScreen = 'main_screen';
  static const homePage = 'home_page';
  static const toDoListPage = 'to_do_list_page';
  static const notificationsPage = 'notifications_page';
  static const searchPage = 'search_page';
  static const addTaskPage = 'add_task_page';
  static const detailsPage = 'details_page';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page|View|Screen,Route',
  routes: [
    AutoRoute<void>(
      path: Routes.authScreen,
      initial: true,
      page: AuthenticationPage,
    ),
    AutoRoute<void>(
      path: Routes.mainScreen,
      name: 'MainScreenRoute',
      page: BottomNavBarPage,
      children: [
        AutoRoute<void>(
          page: HomePage,
          initial: true,
          path: Routes.homePage,
        ),
        AutoRoute<void>(
          page: EmptyRouterPage,
          path: Routes.toDoListPage,
          name: 'ToDoListEmptyRoute',
          children: [
            AutoRoute<void>(
              page: ToDoListPage,
              initial: true,
            ),
            AutoRoute<void>(
              page: AddTaskPage,
              path: Routes.addTaskPage,
            ),
          ],
        ),
        AutoRoute<void>(
          page: NotificationsPage,
          path: Routes.notificationsPage,
        ),
        AutoRoute<void>(
          page: SearchEmptyPage,
          path: Routes.searchPage,
          name: 'SearchEmptyRoute',
          children: [
            AutoRoute<void>(
              page: SearchPage,
              initial: true,
            ),
            AutoRoute<void>(
              path: '${Routes.detailsPage}/:id',
              page: DetailsPage,
            ),
          ],
        ),
      ],
    ),
  ],
)

class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  AppRouter._();

  factory AppRouter.instance() => _router;
}
