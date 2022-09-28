import 'dart:math';

import 'package:app_artistica/components/containers.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class IconRoundedComponent extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final double angle;
  final Color? colorIcon;
  const IconRoundedComponent(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.angle = 90 * pi / 1,
      this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ContainerRoundedComponent(
        child: Transform.rotate(
          angle: angle,
          child: Icon(
            icon,
            color: colorIcon ?? ThemeProvider.themeOf(context).data.hintColor,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
