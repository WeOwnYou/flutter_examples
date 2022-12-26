import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vedita_learning2/app_settings/app_colors.dart';
import 'package:vedita_learning2/life_cycle_manager.dart';
import 'package:vedita_learning2/navigation/router.dart';
import 'package:vedita_learning2/ui/authentication/authentication.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  const MyApp({
    super.key,
    required this.userRepository,
    required this.authenticationRepository,
  });
  @override
  Widget build(BuildContext context) {
    // return RepositoryProvider<AuthenticationRepository>.value(
    //   value: authenticationRepository,
    //   child:
      return
        BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: LifeCycleManager(
          child: MaterialApp.router(
            theme: ThemeData(backgroundColor: AppColors.backgroundColor),
            routerDelegate: AppRouter.instance().delegate(),
            routeInformationParser: AppRouter.instance().defaultRouteParser(),
            builder: buildBlocListener,
          ),
        ),
      );
    // );
  }

  Widget buildBlocListener(BuildContext context, Widget? child) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.unknown:
            break;
          case AuthenticationStatus.authenticated:
            AppRouter.instance().replace(
              MainScreenRoute(
                hiveRepository: HiveRepository(),
                userRepository: userRepository,
              ),
            );
            break;
          case AuthenticationStatus.unauthenticated:
            // AppRouter.instance().replace(
            //   MainScreenRoute(
            //     hiveRepository: HiveRepository(),
            //     userRepository: userRepository,
            //   ),
            // );
            AppRouter.instance()
                .replace(AuthenticationRoute(status: state.status));
            break;
          case AuthenticationStatus.registering:
            AppRouter.instance()
                .replace(AuthenticationRoute(status: state.status));
            break;
          case AuthenticationStatus.failure:
            AppRouter.instance()
                .replace(AuthenticationRoute(status: state.status));
            break;
        }
      },
      child: child,
    );
  }
}
