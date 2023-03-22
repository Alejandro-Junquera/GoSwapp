import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import 'auth_service.dart';

class AlumnoService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  List<EstudianteInfo> info = [];
  List<TareasAlumnoCiclo> tareas = [];
  List<TareasAsignadasAlumno> tareasAsignadas = [];
  List<AlumnoPerfilData> perfil = [];
  bool isLoading = true;

  getTareas() async {
    tareas.clear();
    tareasAsignadas.clear();
    info.clear();
    String? token = await AuthService().readToken();
    final url = Uri.http(_baseUrl, '/public/api/task-assignments/cicle');
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
    var tareasAlumno = TareasAlumno.fromJson(decodedResp);
    print(decodedResp);
    String boscoins = decodedResp['estudiante']['boscoins'].toString();

    info.add(tareasAlumno.estudiante!);
    for (var i in tareasAlumno.tareas!) {
      if (i.grade != 'null') {
        tareas.add(i);
      }
    }
    for (var i in tareasAlumno.tareasAsignadas!) {
      tareasAsignadas.add(i);
    }
    isLoading = false;
    notifyListeners();
    return boscoins;
  }

  solicitarTarea(int alumnoId, int tareaId) async {
    String? token = await AuthService().readToken();

    final url =
        Uri.http(_baseUrl, '/public/api/assign-task/$alumnoId/$tareaId');
    isLoading = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(resp.body);
    print(decodedResp);
    isLoading = false;
    notifyListeners();
    return null;
  }

  obtenerPerfilAlumno() async {
    perfil.clear();
    String? token = await AuthService().readToken();
    String? id = await AuthService().readId();
    final url = Uri.http(_baseUrl, '/public/api/students');
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
    var allAlumnos = Alumnos.fromJson(decodedResp);

    for (var i in allAlumnos.estudiantes!) {
      if (i.userId.toString() == id) {
        perfil.add(i);
      }
    }
    isLoading = false;
    notifyListeners();
    return perfil;
  }
}
