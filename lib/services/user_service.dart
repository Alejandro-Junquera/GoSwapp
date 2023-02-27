import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'services.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  bool isLoading = true;
  final List<TareasDataUser> misTareas = [];

  obtenerTareasUsuario() async {
    misTareas.clear();
    String? token = await AuthService().readToken();
    String? idUser = await AuthService().readId();
    final url = Uri.http(_baseUrl, '/public/api/tasks');
    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    var tareasUser = TareasUser.fromJson(decodedResp);
    for (var i in tareasUser.tareas!) {
      if (i.userId == int.parse(idUser!)) {
        misTareas.add(i);
      }
    }
    isLoading = false;
    notifyListeners();
    return misTareas;
  }

  crearNuevaTareaUsuario(String title, String description, int num_boscoins,
      String imagen, int cicle_id) async {
    String? idUser = await AuthService().readId();
    String? token = await AuthService().readToken();
    final Map<String, dynamic> nuevaTarea = {
      'title': title,
      'description': description,
      'num_boscoins': num_boscoins,
      'imagen': imagen,
      'user_id': idUser,
      'cicle_id': cicle_id
    };
    final url = Uri.http(_baseUrl, '/public/api/tasks');
    isLoading = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode(nuevaTarea),
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    isLoading = false;
    notifyListeners();
    return decodedResp;
  }
}
