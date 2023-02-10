import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_screen_view_model.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double latitude = context.select((MainScreenVM vm) => vm.latitude);
    final double longitude = context.select((MainScreenVM vm) => vm.longitude);
    final String address = context.select((MainScreenVM vm) => vm.address);
    final onTap = context.read<MainScreenVM>().onGetAddressesTap;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){onTap();},
        child: const Icon(Icons.ac_unit_outlined),
      ),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$latitude, $longitude'),
            Text(address),
          ],
        ),
      ),
    );
  }
}
