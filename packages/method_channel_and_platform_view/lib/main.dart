import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/home_page_view.dart';
import 'src/home_page_vm.dart';

class MethodChannelAndPlatformView extends StatelessWidget {
  const MethodChannelAndPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (_) => HomePageVm(), child: const MyHomePage()),
    );
  }
}
