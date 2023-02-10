import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class CustomScrollPhysics extends ClampingScrollPhysics {
  final double velocity;
  final double acceleration;
  const CustomScrollPhysics({this.velocity = 0, this.acceleration = 0});
  @override
  ClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return const CustomScrollPhysics();
  }

  CustomScrollPhysics copyWith(double velocity, double acceleration){
    print('copied $velocity, $acceleration');
    return CustomScrollPhysics(
      velocity: velocity,
      acceleration: acceleration,
    );
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    print('here');
    return SpringSimulation(spring, position.pixels, position.pixels + 10, 300);
    // return CustomSimulation(
    //   initPosition: position.pixels,
    //   velocity: 1000,
    //   acceleration: -500,
    // );
  }
  @override
  bool get allowImplicitScrolling => true;
  @override
  SpringDescription get spring => const SpringDescription(
    mass: 80,
    stiffness: 100,
    damping: 1,
  );
}

class CustomSimulation extends Simulation {
  final double initPosition;
  final double velocity;
  final double acceleration;
  double? endPoint;

  CustomSimulation({required this.initPosition, required this.velocity, required this.acceleration,});

  @override
  double x(double time) {
    // velocity -= 0.3;
    // velocity = velocity < 0 ? 0 : velocity;
    // print(velocity.toString() + '!!!');
    // print('$velocity <= ${-acceleration * time / 2}');
    // print('${velocity * time} == ${acceleration * pow(time,2) / 2}');
    // if(endPoint == null && velocity <= - acceleration * time / 2){
    //   endPoint = initPosition + velocity * time + acceleration * pow(time,2) / 2;
    // }
    var maximum =
    max(max(min(initPosition, 0.0), initPosition + velocity * time + acceleration * pow(time,2)), endPoint??0);
    endPoint = maximum;
    // print(initPosition + velocity * time + acceleration * pow(time,2) / 2);
    // print(maximum);
    // print(maximum);
    print(velocity);
    return endPoint ?? maximum;
  }

  @override
  double dx(double time) {
    // print(velocity.toString());
    // velocity -= 10;
    print(velocity.toString() + '!!!!');
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }
}