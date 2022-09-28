import 'package:flutter/material.dart';

class FormButtom extends StatelessWidget {
  const FormButtom({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: FormButtomPainter(),
      ),
    );
  }
}

class FormButtomPainter extends CustomPainter {
  @override
void paint(Canvas canvas, Size size) {
  final paint = Paint()
    ..color = const Color(0xff1E88B3)
    ..strokeWidth = 2
    ..style = PaintingStyle.fill; //stroke //fill
    
  final path = Path()
    ..moveTo(0, size.height)
    ..quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.75,
        size.width * 0.5,
        size.height * 0.78)
    ..quadraticBezierTo(
        size.width/1.2,
        size.height * 0.8,
        size.width,
        size.height * 0.65)
    ..lineTo(size.width,size.height)
    ..close();
  canvas.drawPath(path, paint);
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class Formtop extends StatelessWidget {
  const Formtop({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: FormtopPainter(),
      ),
    );
  }
}

class FormtopPainter extends CustomPainter {
  @override
void paint(Canvas canvas, Size size) {
  final paint = Paint()
    ..color = const Color(0xffD89E49)
    ..strokeWidth = 2
    ..style = PaintingStyle.fill; //stroke //fill
    
  final path = Path()
    ..lineTo(0, size.height/2)
    ..quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.35,
        size.width * 0.5,
        size.height * 0.38)
    ..quadraticBezierTo(
        size.width/1.2,
        size.height * 0.4,
        size.width,
        size.height * 0.15)
    ..lineTo(size.width,0)
    ..close();
  canvas.drawPath(path, paint);
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}