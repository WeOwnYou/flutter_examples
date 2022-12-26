// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthenticationRouteArgs>(
          orElse: () => const AuthenticationRouteArgs());
      return MaterialPageX<void>(
        routeData: routeData,
        child: AuthenticationPage(
          key: args.key,
          status: args.status,
        ),
      );
    },
    MainScreenRoute.name: (routeData) {
      final args = routeData.argsAs<MainScreenRouteArgs>();
      return MaterialPageX<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: BottomNavBarPage(
          key: args.key,
          hiveRepository: args.hiveRepository,
          userRepository: args.userRepository,
        )),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: WrappedRoute(child: const HomePage()),
      );
    },
    ToDoListEmptyRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    NotificationsRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: const NotificationsPage(),
      );
    },
    SearchEmptyRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: WrappedRoute(child: const SearchEmptyPage()),
      );
    },
    ToDoListRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: WrappedRoute(child: const ToDoListPage()),
      );
    },
    AddTaskRoute.name: (routeData) {
      final args = routeData.argsAs<AddTaskRouteArgs>();
      return MaterialPageX<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: AddTaskPage(
          key: args.key,
          hiveRepository: args.hiveRepository,
          selectedDate: args.selectedDate,
        )),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => const SearchRouteArgs());
      return MaterialPageX<void>(
        routeData: routeData,
        child: SearchPage(
          key: args.key,
          keyword: args.keyword,
        ),
      );
    },
    DetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailsRouteArgs>(
          orElse: () => DetailsRouteArgs(nasaId: pathParams.getString('id')));
      return MaterialPageX<void>(
        routeData: routeData,
        child: DetailsPage(
          key: args.key,
          nasaId: args.nasaId,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'auth_screen',
          fullMatch: true,
        ),
        RouteConfig(
          AuthenticationRoute.name,
          path: 'auth_screen',
        ),
        RouteConfig(
          MainScreenRoute.name,
          path: 'main_screen',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: MainScreenRoute.name,
              redirectTo: 'home_page',
              fullMatch: true,
            ),
            RouteConfig(
              HomeRoute.name,
              path: 'home_page',
              parent: MainScreenRoute.name,
            ),
            RouteConfig(
              ToDoListEmptyRoute.name,
              path: 'to_do_list_page',
              parent: MainScreenRoute.name,
              children: [
                RouteConfig(
                  ToDoListRoute.name,
                  path: '',
                  parent: ToDoListEmptyRoute.name,
                ),
                RouteConfig(
                  AddTaskRoute.name,
                  path: 'add_task_page',
                  parent: ToDoListEmptyRoute.name,
                ),
              ],
            ),
            RouteConfig(
              NotificationsRoute.name,
              path: 'notifications_page',
              parent: MainScreenRoute.name,
            ),
            RouteConfig(
              SearchEmptyRoute.name,
              path: 'search_page',
              parent: MainScreenRoute.name,
              children: [
                RouteConfig(
                  SearchRoute.name,
                  path: '',
                  parent: SearchEmptyRoute.name,
                ),
                RouteConfig(
                  DetailsRoute.name,
                  path: 'details_page/:id',
                  parent: SearchEmptyRoute.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [AuthenticationPage]
class AuthenticationRoute extends PageRouteInfo<AuthenticationRouteArgs> {
  AuthenticationRoute({
    Key? key,
    AuthenticationStatus status = AuthenticationStatus.unknown,
  }) : super(
          AuthenticationRoute.name,
          path: 'auth_screen',
          args: AuthenticationRouteArgs(
            key: key,
            status: status,
          ),
        );

  static const String name = 'AuthenticationRoute';
}

class AuthenticationRouteArgs {
  const AuthenticationRouteArgs({
    this.key,
    this.status = AuthenticationStatus.unknown,
  });

  final Key? key;

  final AuthenticationStatus status;

  @override
  String toString() {
    return 'AuthenticationRouteArgs{key: $key, status: $status}';
  }
}

/// generated route for
/// [BottomNavBarPage]
class MainScreenRoute extends PageRouteInfo<MainScreenRouteArgs> {
  MainScreenRoute({
    Key? key,
    required HiveRepository hiveRepository,
    required UserRepository userRepository,
    List<PageRouteInfo>? children,
  }) : super(
          MainScreenRoute.name,
          path: 'main_screen',
          args: MainScreenRouteArgs(
            key: key,
            hiveRepository: hiveRepository,
            userRepository: userRepository,
          ),
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';
}

class MainScreenRouteArgs {
  const MainScreenRouteArgs({
    this.key,
    required this.hiveRepository,
    required this.userRepository,
  });

  final Key? key;

  final HiveRepository hiveRepository;

  final UserRepository userRepository;

  @override
  String toString() {
    return 'MainScreenRouteArgs{key: $key, hiveRepository: $hiveRepository, userRepository: $userRepository}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home_page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [EmptyRouterPage]
class ToDoListEmptyRoute extends PageRouteInfo<void> {
  const ToDoListEmptyRoute({List<PageRouteInfo>? children})
      : super(
          ToDoListEmptyRoute.name,
          path: 'to_do_list_page',
          initialChildren: children,
        );

  static const String name = 'ToDoListEmptyRoute';
}

/// generated route for
/// [NotificationsPage]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute()
      : super(
          NotificationsRoute.name,
          path: 'notifications_page',
        );

  static const String name = 'NotificationsRoute';
}

/// generated route for
/// [SearchEmptyPage]
class SearchEmptyRoute extends PageRouteInfo<void> {
  const SearchEmptyRoute({List<PageRouteInfo>? children})
      : super(
          SearchEmptyRoute.name,
          path: 'search_page',
          initialChildren: children,
        );

  static const String name = 'SearchEmptyRoute';
}

/// generated route for
/// [ToDoListPage]
class ToDoListRoute extends PageRouteInfo<void> {
  const ToDoListRoute()
      : super(
          ToDoListRoute.name,
          path: '',
        );

  static const String name = 'ToDoListRoute';
}

/// generated route for
/// [AddTaskPage]
class AddTaskRoute extends PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    Key? key,
    required HiveRepository hiveRepository,
    required DateTime selectedDate,
  }) : super(
          AddTaskRoute.name,
          path: 'add_task_page',
          args: AddTaskRouteArgs(
            key: key,
            hiveRepository: hiveRepository,
            selectedDate: selectedDate,
          ),
        );

  static const String name = 'AddTaskRoute';
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({
    this.key,
    required this.hiveRepository,
    required this.selectedDate,
  });

  final Key? key;

  final HiveRepository hiveRepository;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key, hiveRepository: $hiveRepository, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    Key? key,
    String keyword = '',
  }) : super(
          SearchRoute.name,
          path: '',
          args: SearchRouteArgs(
            key: key,
            keyword: keyword,
          ),
        );

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.keyword = '',
  });

  final Key? key;

  final String keyword;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, keyword: $keyword}';
  }
}

/// generated route for
/// [DetailsPage]
class DetailsRoute extends PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    Key? key,
    required String nasaId,
  }) : super(
          DetailsRoute.name,
          path: 'details_page/:id',
          args: DetailsRouteArgs(
            key: key,
            nasaId: nasaId,
          ),
          rawPathParams: <String, String>{'id': nasaId},
        );

  static const String name = 'DetailsRoute';
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.nasaId,
  });

  final Key? key;

  final String nasaId;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, nasaId: $nasaId}';
  }
}
