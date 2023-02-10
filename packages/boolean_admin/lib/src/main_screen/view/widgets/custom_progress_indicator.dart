import 'package:boolean_admin/src/res/app_colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatefulWidget {
  final Widget child;
  final double indicatorSize;
  final double verticalPadding;
  final Future<void> Function() onRefresh;
  const CustomProgressIndicator({
    Key? key,
    required this.child,
    required this.indicatorSize,
    required this.verticalPadding, required this.onRefresh,
  }) : super(key: key);

  @override
  CustomProgressIndicatorState createState() => CustomProgressIndicatorState();
}

class CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final double _containerSize;
  late bool _isVisible;
  @override
  void initState() {
    _containerSize = widget.verticalPadding * 2 + widget.indicatorSize;
    _isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _containerSize,
      onRefresh: widget.onRefresh,
      child: widget.child,
      onStateChanged: (change) {
        if (change.didChange(to: IndicatorState.idle)) {
          setState(() {
            _isVisible = false;
          });
        } else {
          setState(() {
            _isVisible = true;
          });
        }
      },
      builder: (context, child, controller) {
        return Stack(
          children: <Widget>[
            if (!_isVisible)
              const SizedBox.shrink()
            else
              AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  final containerHeight = controller.value * _containerSize;
                  return AnimatedContainer(
                    alignment: Alignment.center,
                    height: containerHeight,
                    width: MediaQuery.of(context).size.width,
                    duration: const Duration(milliseconds: 100),
                    child: SizedBox(
                      height: widget.indicatorSize,
                      width: widget.indicatorSize,
                      child: CircularProgressIndicator.adaptive(
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.progressIndicatorColor,
                        ),
                        value: controller.isDragging || controller.isArmed
                            ? controller.value.clamp(0, 1)
                            : null,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      // color: Colors.black,
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _containerSize),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
    );
  }
}
