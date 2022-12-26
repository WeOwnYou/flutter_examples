import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_project/examples/sliver_bottom_sheet/app_colors.dart';
import 'package:test_project/examples/sliver_bottom_sheet/widgets/bouncing_widget.dart';
import 'package:test_project/examples/sliver_bottom_sheet/widgets/sliver_group/src/widget/sliver_group_builder.dart';

const double _kFlexibleFromHeight = 0.2;
const _kMainVerticalPadding = 20.0;
const _kMainHorizontalPadding = 15.0;

class SliverBottomSheet extends StatefulWidget {
  const SliverBottomSheet({Key? key}) : super(key: key);

  @override
  State<SliverBottomSheet> createState() => _SliverBottomSheetState();
}

class _SliverBottomSheetState extends State<SliverBottomSheet> {
  late final ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.mainBluePurple,
            AppColors.bgLightOrange,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.43],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverPersistentHeader(
              delegate: _HeaderDelegate(
                  controller: _controller,
                  height: MediaQuery.of(context).size.height *
                      _kFlexibleFromHeight),
            ),
            //just wrapper to add Decoration to SliverList
            SliverGroupBuilder(
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50))),
              child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (ctx, index) => ListTile(
                            title: Text('tile $index'),
                          ),
                      childCount: 40)),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController controller;
  final double height;

  _HeaderDelegate({
    required this.controller,
    required this.height,
  });

  double get topPadding => min(
        _kMainVerticalPadding * 2,
        max(
          0,
          _kMainVerticalPadding -
              (controller.hasClients ? controller.offset / 10 : 0),
        ),
      );

  double get bottomPadding => min(
        _kMainVerticalPadding * 2,
        max(
          0,
          _kMainVerticalPadding +
              (controller.hasClients ? controller.offset / 10 : 0),
        ),
      );

  double _getOpacity(BuildContext context) {
    double result = 1;
    if (!controller.hasClients) return result;
    result = 1 -
        (controller.offset /
            ((MediaQuery.of(context).size.height * 0.2) / 100) /
            100);
    if (result < 0) {
      result = 0;
    } else if (result > 1) {
      result = 1;
    }
    return result;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      children: [
        Positioned(
          top: shrinkOffset,
          bottom: controller.offset > 0 ? 0 - shrinkOffset : null,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: _getOpacity(context),
            child: SizedBox(
              height: height,
              child: ListView(
                padding: EdgeInsets.only(
                  top: topPadding,
                  bottom: bottomPadding,
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  _BuildTopsideCartWidget(
                    title: 'Додокоины',
                    subtitle: '123',
                    bottom: 'Нажмите, \nчтобы потратить',
                    image: const ClipPath(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Icon(
                        Icons.currency_bitcoin,
                        size: 60,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  _BuildTopsideCartWidget(
                    title: 'История\nзаказов',
                    bottom: 'Тест',
                    // '${state.ordersHistory.total} ${state.ordersHistory.total.declension('заказ', 'заказа', 'заказов')}',
                    onPressed: () {},
                  ),
                  _BuildTopsideCartWidget(
                    title: 'Адреса\nдоставки',
                    bottom: 'тест 2',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

const kMainHorizontalPadding = 15.0;
const kMainBorderRadius = 14.0;

class _BuildTopsideCartWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String bottom;
  final Widget? image;
  final VoidCallback onPressed;
  const _BuildTopsideCartWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.bottom,
    this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: image == null ? 50.0 : 0.0,
          bottom: image == null ? kMainHorizontalPadding : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (subtitle != null)
              const SizedBox(
                height: 5,
              ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  bottom,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.mainIconGrey,
                  ),
                ),
                if (image != null) image!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
