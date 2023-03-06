// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aplicacion_ganadora/services/services.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class TeacherService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  bool isLoading = true;
  final List<TareaDelCiclo> tareasProf = [];

  obtenerTareasDeUnCiclo() async {
    tareasProf.clear();
    String? token = await AuthService().readToken();
    String? cicleId = await AuthService().readCicleId();
    final url = Uri.http(_baseUrl, '/public/api/tasks/cicle/$cicleId');
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
    var tareasUser = TareasDelCiclo.fromJson(decodedResp);
    for (var i in tareasUser.tareasDelCiclo!) {
      if (i.grade == '0.00') {
        tareasProf.add(i);
      }
    }
    isLoading = false;
    notifyListeners();
    return tareasProf;
  }

  obtenerTareasPublicadasDeUnCiclo() async {
    tareasProf.clear();
    String? token = await AuthService().readToken();
    String? cicleId = await AuthService().readCicleId();
    final url = Uri.http(_baseUrl, '/public/api/tasks/cicle/$cicleId');
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

    var tareasUser = TareasDelCiclo.fromJson(decodedResp);
    for (var i in tareasUser.tareasDelCiclo!) {
      if (i.grade != '0.00') {
        tareasProf.add(i);
      }
    }
    isLoading = false;
    notifyListeners();
    return tareasProf;
  }

  asignarDificultadTarea(double grade, int idTarea) async {
    String? token = await AuthService().readToken();
    final Map<String, dynamic> asignarDificultad = {
      'grade': grade,
    };
    final url = Uri.http(_baseUrl, '/public/api/tasks/$idTarea/rate');
    isLoading = true;
    notifyListeners();
    final resp = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
      body: json.encode(asignarDificultad),
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    isLoading = false;
    notifyListeners();
    return null;
  }

  eliminarUnaTarea(int idTarea) async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, '/public/api/tasks/$idTarea');
    isLoading = true;
    notifyListeners();
    final resp = await http.delete(
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
  }
}
