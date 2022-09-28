import 'package:flutter/material.dart';

class AppState with ChangeNotifier {

  int selectedIndexScreen = 0;
  updateSelectedIndexScreenId(int data) {
    selectedIndexScreen = data;
    notifyListeners();
  }
  List fechasProvider = [];
  updateFechaProvider(List fechasProvider) {
    fechasProvider = fechasProvider;
    notifyListeners();
  }

  bool stateFacturado = true;
  bool get stateFacturadoGet => stateFacturado;
  set stateFacturadoUpdate(bool stateFacturado) {
    this.stateFacturado = stateFacturado;
    notifyListeners();
  }

  bool stateAnulado = true;
  bool get stateAnuladoGet => stateAnulado;
  set stateAnuladoUpdate(bool stateAnulado) {
    this.stateAnulado = stateAnulado;
    notifyListeners();
  }
}
