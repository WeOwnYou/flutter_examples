import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/main_view/bloc/main_bloc.dart';
import 'src/main_view/view/main_view.dart';

class WorkersTree extends StatelessWidget {
  const WorkersTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (ctx) => MainBloc()..add(const MainInitializeEvent()),
        child: const MainView(),
      ),
    );
  }
}
