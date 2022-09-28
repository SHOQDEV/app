import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/terms_conditions.dart';
// import 'package:app_artistica/components/terms_conditions.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabScreenTermAndConditions extends StatefulWidget {
  final Function() nextScreen;
  const TabScreenTermAndConditions({Key? key, required this.nextScreen})
      : super(key: key);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreenTermAndConditions> {
  bool _isChecked = false;
  bool informed = false;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
        } else {
          setState(() {
            informed = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height <
                    MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height / 1.16,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        controller: _controller,
                        child: const WidgetTermConditions()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                          visible: informed,
                          child: Row(
                            children: [
                              const Text('Acepto'),
                              Checkbox(
                                activeColor: const Color(0xffD89E49),
                                value: _isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isChecked = newValue!;
                                  });
                                },
                              ),
                            ],
                          )),
                      ButtonComponent(
                          text: 'Empezar',
                          onPressed: ()=> _isChecked ? widget.nextScreen() : null),
                    ],
                  ),
                ],
              ),
            )));
  }
}
