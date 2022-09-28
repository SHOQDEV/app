
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ComponentHeader extends StatelessWidget {
  final String text;
  final bool stateBack;
  const ComponentHeader({Key? key, required this.text, required this.stateBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (stateBack)
          Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: Icon(Icons.arrow_back_ios,color: ThemeProvider.themeOf(context).data.hintColor),
                  ))),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('app_artistica'),
            Text(text,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        ),
        
        const Spacer(),
        Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/icons/factufacil.png',
                        width: 50, height: 50, fit: BoxFit.cover)),
      ],
    );
  }
}
