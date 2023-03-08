import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/models.dart';
import 'services.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  bool isLoading = true;
  final List<TareasDataUser> misTareas = [];

  File? newPictureFile;

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

  crearNuevaTareaUsuario(
    String title,
    String description,
    String address,
    String phone,
  ) async {
    String? idUser = await AuthService().readId();
    String? token = await AuthService().readToken();

    List<int> imageBytes = await newPictureFile!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);

    final Map<String, dynamic> nuevaTarea = {
      'title': title,
      'description': description,
      'client_address': address,
      'client_phone': phone,
      'imagen': base64Image,
      'user_id': idUser,
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

  void updateImage(String path) {
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  valorarTarea(int tareaId, double rating, String comentario) async {
    String? token = await AuthService().readToken();
    String puntuacion = rating.toString();
    final Map<String, dynamic> valoraciones = {
      'comment': comentario,
      'client_rating': puntuacion,
    };
    final url = Uri.http(_baseUrl, '/public/api/completed-tasks/$tareaId/rate');
    isLoading = true;
    notifyListeners();
    final resp = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode(valoraciones),
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    isLoading = false;
    notifyListeners();
    return null;
  }
}
