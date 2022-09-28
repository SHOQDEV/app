import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ComponentAnimate extends StatelessWidget {
  final Widget child;
  const ComponentAnimate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      duration : const Duration(milliseconds: 1500),
      from: 200,
      child: child);
  }
}