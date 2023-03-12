import 'package:flutter/material.dart';

class NuevoProfProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String nombre = '';
  String apellido = '';
  String email = '';
  String contrasenia = '';

  String c_contrasenia = '';
  String telefono = '';
  String direccion = '';
  int ciclos_id = 0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
