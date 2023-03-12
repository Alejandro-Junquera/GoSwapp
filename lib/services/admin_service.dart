import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class AdminService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  bool isLoading = true;
  final List<TareasDataUser> tareasPorAsignar = [];
  final List<ProfesorData> profesores = [];

  obtenerTareasSinCiclo() async {
    tareasPorAsignar.clear();
    String? token = await AuthService().readToken();
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
    var tareaSinCiclo = TareasUser.fromJson(decodedResp);
    print(decodedResp);
    for (var i in tareaSinCiclo.tareas!) {
      if (i.cicleId == null) {
        tareasPorAsignar.add(i);
      }
    }
    isLoading = false;
    notifyListeners();
    return tareasPorAsignar;
  }

  asignarCicloaTarea(int idTarea, int cicloId) async {
    String? token = await AuthService().readToken();
    final url =
        Uri.http(_baseUrl, '/public/api/tasks/$idTarea/assign-cicle/$cicloId');
    isLoading = true;
    notifyListeners();
    // ignore: unused_local_variable
    final resp = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
    );

    isLoading = false;
    notifyListeners();
    return null;
  }

  obtenerProfesores() async {
    profesores.clear();
    String? token = await AuthService().readToken();
    final url = Uri.http(_baseUrl, '/public/api/teachers');
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
    print(decodedResp);
    var profesor = Profesores.fromJson(decodedResp);
    for (var i in profesor.profesores!) {
      profesores.add(i);
    }
    isLoading = false;
    notifyListeners();
    return profesores;
  }
}
