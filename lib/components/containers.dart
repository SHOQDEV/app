import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ContainerComponent extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  const ContainerComponent({Key? key, required this.child, this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Container(
            width:width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color:
                  ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(1, 1),
                )
              ],
            ),
            child: child));
  }
}

class ContainerRoundedComponent extends StatelessWidget {
  final Widget child;
  const ContainerRoundedComponent({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
    child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: child));
  }
}
