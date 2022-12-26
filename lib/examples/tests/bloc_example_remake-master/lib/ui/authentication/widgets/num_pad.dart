import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/ui/authentication/authentication.dart';

class BuildNumPadWidget extends StatelessWidget {
  const BuildNumPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 13;
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: [
          ...List.generate(
            9,
            (index) => _NumPadButtonWidget(
              digit: index + 1,
              widget: Text(
                (index + 1).toString(),
                style: textStyle,
              ),
              circleSize: size,
            ),
          ),
          _NumPadButtonWidget(
            widget: const Icon(Icons.backspace),
            circleSize: size,
          ),
          _NumPadButtonWidget(
            digit: 0,
            widget: const Text(
              '0',
              style: textStyle,
            ),
            circleSize: size,
          ),
          _NumPadButtonWidget(
            widget: const Icon(Icons.done),
            circleSize: size,
          ),
        ],
      ),
    );
  }
}

class _NumPadButtonWidget extends StatelessWidget {
  final Widget widget;
  final int? digit;
  final double circleSize;
  const _NumPadButtonWidget({
    Key? key,
    required this.widget,
    required this.circleSize,
    this.digit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(circleSize / 2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circleSize * 2),
          ),
        ),
        onPressed: () {
          if (digit != null) {
            context.read<AuthenticationBloc>().add(PinChanged(digit!));
          } else {
            context.read<AuthenticationBloc>().add(const PinChanged(-1));
          }
        },
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
