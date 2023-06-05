import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  bool isLoading = true;
  final List<TareasDataUser> misTareas = [];

  File? newPictureFile;
  bool editProfile = false;

  isEditable() {
    if (editProfile == false) {
      editProfile = true;
    } else {
      editProfile = false;
    }
    notifyListeners();
  }

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
    Map<String, dynamic>? perfil = await obtenerPerfilUser();
    isLoading = true;
    notifyListeners();
    if (address == '') {
      address = perfil!['Usuario']['address'];
    }
    if (phone == '') {
      phone = perfil!['Usuario']['mobile'];
    }
    final Map<String, String> nuevaTarea = {
      'title': title,
      'description': description,
      'client_address': address,
      'client_phone': phone,
      'user_id': idUser.toString(),
    };
    if (newPictureFile != null) {
      final url = Uri.http(_baseUrl, '/public/api/tasks');
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..fields.addAll(nuevaTarea)
        ..files.add(
            await http.MultipartFile.fromPath('imagen', newPictureFile!.path));

      final response = await http.Response.fromStream(await request.send());
    } else {
      final url = Uri.http(_baseUrl, '/public/api/tasks');
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..fields.addAll(nuevaTarea);

      final response = await http.Response.fromStream(await request.send());
    }
    newPictureFile = null;
    isLoading = false;
    notifyListeners();
    return null;
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

  obtenerPerfilUser() async {
    String? token = await AuthService().readToken();
    String? id = await AuthService().readId();
    final url = Uri.http(_baseUrl, '/public/api/users/$id');
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
    isLoading = false;
    notifyListeners();
    return decodedResp;
  }

  actualizarUsuario(String firstname, String surname, String email,
      String mobile, String address) async {
    String? token = await AuthService().readToken();
    String? id = await AuthService().readId();
    print(id);
    final Map<String, dynamic> actualizarUsuario = {
      'firstname': firstname,
      'surname': surname,
      'email': email,
      'mobile': mobile,
      'address': address
    };
    final url = Uri.http(_baseUrl, '/public/api/students/$id');
    isLoading = true;
    notifyListeners();
    // ignore: unused_local_variable
    final resp = await http.patch(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode(actualizarUsuario),
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    isLoading = false;
    notifyListeners();
    return null;
  }
}
