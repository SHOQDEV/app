import 'package:app_artistica/screens/introductionScreen/liquid_pages.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class ScreenSlider extends StatefulWidget {
  const ScreenSlider({Key? key}) : super(key: key);

  @override
  _ScreenSliderState createState() => _ScreenSliderState();
}

class _ScreenSliderState extends State<ScreenSlider> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: LiquidSwipe(
            pages: liquidPages,
            enableLoop: true,
            fullTransitionValue: 500,
            waveType: WaveType.liquidReveal,
            positionSlideIcon: 0.25,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pushReplacementNamed(context, 'navigator'),
            label: const Text(
              'EMPEZAR',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.pink,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }
}
