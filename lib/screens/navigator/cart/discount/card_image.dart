import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final Function()? nextScreen;
  final String image;
  final String text;
  const CardImage(
      {Key? key, this.nextScreen, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.6 / 2,
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 5,
            child: Column(
              mainAxisAlignment : MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                const Divider(),
                Text(text)
              ],
            )),
      ),
      onTap: nextScreen,
    );
  }
}