import 'dart:async';

import 'package:boolean_admin/src/main_screen/bloc/main_bloc.dart';
import 'package:boolean_admin/src/main_screen/view/main_view.dart';
import 'package:boolean_admin/src/res/app_colors.dart';
import 'package:boolean_admin_repository/boolean_admin_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void run() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded<Future<void>>(() async {
    await Firebase.initializeApp();
    final a = BooleanAdminRepository();
    runApp(
      RepositoryProvider(
        create: (ctx) => a,
        child: const BooleanAdmin(),
      ),
    );
  }, (error, stack) {
    debugPrint('ERROR');
    debugPrint('$error');
    debugPrint('$stack');
    debugPrint('END ERROR');
  });
}

extension CheckConnection on ConnectivityResult? {
  bool get hasInternet {
    switch (this) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
        return true;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.none:
      default:
        return false;
    }
  }
}

class BooleanAdmin extends StatelessWidget {
  const BooleanAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (ctx) => MainBloc(
          booleanAdminRepository: context.read<BooleanAdminRepository>(),
        ),
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            final hasInternet = snapshot.data.hasInternet;
            context
                .read<MainBloc>()
                .add(UpdateConnectionStatusEvent(hasInternet: hasInternet));
            return const MainView();
          },
        ),
      ),
    );
  }
}
