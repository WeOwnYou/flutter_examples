import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/ui/authentication/authentication.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;
  const LifeCycleManager({Key? key, required this.child}) : super(key: key);
  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (_timer?.isActive ?? false) _timer?.cancel();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        _timer ??= Timer(const Duration(seconds: 5), () {
          print('exited');
          setState(() {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested());
          });
        });
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: widget.child,
    );
  }
}
