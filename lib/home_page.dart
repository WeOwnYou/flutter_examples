import 'package:flutter/material.dart';
import 'package:test_project/examples/sliver_bottom_sheet/sliver_bottom_sheet.dart';
import 'examples/sliver_bottom_sheet/sliver_bottom_sheet2.dart';
import 'examples/sliver_bottom_sheet/sliver_bottom_sheet3.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Examples'),),
      body: ListView(
        children: [
          ListTile(title: const Text('Bottom sheet default'), onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute (
                builder: (BuildContext context) => const SliverBottomSheet(),
              ),
            );
          },),
          ListTile(title: const Text('Bottom sheet experiments with scroll controller'), onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute (
                builder: (BuildContext context) => const SliverBottomSheet2(),
              ),
            );
          },),
          ListTile(title: const Text('Bottom sheet with 2 identical lists'), onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute (
                builder: (BuildContext context) => const SliverBottomSheet3(),
              ),
            );
          },),
        ],
      ),
    );
  }
}
