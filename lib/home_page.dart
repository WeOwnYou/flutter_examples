import 'package:flutter/material.dart';
import 'package:gps_app/gps_app.dart';
import 'package:sliver_bottom_sheets/sliver_bottom_sheets.dart';
import 'package:workers_tree/workers_tree.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Examples'),),
      body: ListView(
        children: [
          ListTile(title: const Text('Sliver Bottom Sheets'), onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute (
                builder: (BuildContext context) => const SliverBottomSheets(),
              ),
            );
          },),
          ListTile(title: const Text('Gps App'), onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute (
                builder: (BuildContext context) => const GpsApp(),
              ),
            );
          },),
          ListTile(title: const Text('Workers Tree'), onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute (
                builder: (BuildContext context) => const WorkersTree(),
              ),
            );
          },),
        ],
      ),
    );
  }
}
