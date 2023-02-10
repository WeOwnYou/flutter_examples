import 'package:flutter/material.dart';

import 'src/sliver_bottom_sheet/sheets/sliver_bottom_sheet.dart';
import 'src/sliver_bottom_sheet/sheets/sliver_bottom_sheet2.dart';
import 'src/sliver_bottom_sheet/sheets/sliver_bottom_sheet3.dart';

class SliverBottomSheets extends StatelessWidget {
  const SliverBottomSheets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliver Bottom Sheets'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Bottom sheet default'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const SliverBottomSheet(),
                ),
              );
            },
          ),
          ListTile(
            title:
                const Text('Bottom sheet experiments with scroll controller'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const SliverBottomSheet2(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom sheet with 2 identical lists'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const SliverBottomSheet3(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
