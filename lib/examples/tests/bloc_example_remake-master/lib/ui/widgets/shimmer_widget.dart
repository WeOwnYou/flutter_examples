import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const ShimmerWidget({this.width, this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
