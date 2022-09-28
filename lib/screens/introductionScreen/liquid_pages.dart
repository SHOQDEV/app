import 'package:flutter/material.dart';

const greyStyle = TextStyle(fontSize: 40.0, color: Colors.white);
const descriptionGreyStyle =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300);
const title =
    TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400);
const subtitle =
    TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold);

final liquidPages = [
  const LiquidPage(
    imageBackground:'assets/images/onboarding_screen/Bg-Blue.png',
    imageFront:"assets/images/onboarding_screen/Shopping-Blue.png",
    titleText:"Elije tus productos o servicios",
    text:"Configura tu app de facturación en linea para agregar tus productos o servicios",
  ),
  const LiquidPage(
    imageBackground:'assets/images/onboarding_screen/Bg-Red.png',
    imageFront:"assets/images/onboarding_screen/Shopping-Red.png",
    titleText:"Obten más comodidad para vender tus productos",
    text:"Descubre una nueva forma de vender tus productos"
  ),
  const LiquidPage(
    imageBackground:'assets/images/onboarding_screen/Bg-Yellow.png',
    imageFront:"assets/images/onboarding_screen/Shopping-Yellow.png",
    titleText:"Supervisa las ventas de tu local",
    text:"Mejora y Controla las ventas de tu local"
  ),
];

class LiquidPage extends StatelessWidget {
  final String imageBackground;
  final String imageFront;
  final String titleText;
  final String text;
  const LiquidPage({Key? key, 
  required this.imageBackground, 
  required this.imageFront, 
  required this.titleText,
  required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(imageBackground),
        fit: BoxFit.fill,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageFront
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  titleText,
                  style: title,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(text,
                  textAlign: TextAlign.center,
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
