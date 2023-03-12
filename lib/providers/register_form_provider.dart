import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String nombre = '';
  String apellido = '';
  String email = '';
  String tel = '';
  String dir = '';
  String contrasenia = '';
  String c_contrasenia = '';

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
