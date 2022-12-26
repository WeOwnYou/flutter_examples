import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/ui/authentication/authentication.dart';

class BuildPinDotesWidget extends StatelessWidget {
  const BuildPinDotesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pin =
        context.select<AuthenticationBloc, String>((bloc) => bloc.state.pin);
    final isFailure = context.select<AuthenticationBloc, AuthenticationStatus>(
          (bloc) => bloc.state.status,
        ) ==
        AuthenticationStatus.failure;
    final padding = isFailure ? 15.0 : 0.0;
    final size = MediaQuery.of(context).size.width / 16.5;
    return AnimatedPadding(
      padding: EdgeInsets.only(left: padding),
      duration: const Duration(microseconds: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            pin.length,
            (_) => _PinDote(size: size, color: Colors.green),
          ),
          ...List.generate(
            4 - pin.length,
            (_) =>
                _PinDote(size: size, color: isFailure ? Colors.red : Colors.grey),
          )
        ],
      ),
    );
  }
}

class _PinDote extends StatelessWidget {
  final Color color;
  final double size;
  const _PinDote({required this.size, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.only(right: size, left: size, top: size * 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
