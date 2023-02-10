import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/main_screen/main_screen_view.dart';
import 'src/main_screen/main_screen_view_model.dart';

class GpsApp extends StatelessWidget {
  const GpsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(create: (BuildContext context) => MainScreenVM(),
      child: const MainScreenView())
    );
  }
}