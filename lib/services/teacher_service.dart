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
  final List<SolicitudTarea> solicitudes = [];
  final List<PerfilP> estudiantesProf = [];
  final List<ProfesorData> profesor = [];

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
      if (i.grade == null) {
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
      if (i.grade != null) {
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

  obtenerSolicitudesAlmunosTarea(int taskId) async {
    solicitudes.clear();
    String? token = await AuthService().readToken();
    final url =
        Uri.http(_baseUrl, '/public/api/tasksAssignment/$taskId/students');
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
    var allSolicitudes = SolicitudesTareas.fromJson(decodedResp);
    for (var i in allSolicitudes.estudiantes!) {
      solicitudes.add(i);
    }
    isLoading = false;
    notifyListeners();
    return solicitudes;
  }

  asignarTarea(int solicitudId) async {
    solicitudes.clear();
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
        _baseUrl, '/public/api/assign-task/$solicitudId/update-assigned-at');
    isLoading = true;
    notifyListeners();
    final resp = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    isLoading = false;
    notifyListeners();
    return null;
  }

  desAsignarTarea(int solicitudId) async {
    solicitudes.clear();
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl,
        '/public/api/assign-task/$solicitudId/unassignTaskFromStudent');
    isLoading = true;
    notifyListeners();
    final resp = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    isLoading = false;
    notifyListeners();
    return null;
  }

  finalizarTarea(int tareaId) async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, '/public/api/tasks/$tareaId/completedTask');
    isLoading = true;
    notifyListeners();
    final resp = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": 'Bearer $token',
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    isLoading = false;
    notifyListeners();
    return null;
  }

  estudiantesConTareasYBoscoins() async {
    estudiantesProf.clear();
    String? token = await AuthService().readToken();
    String? cicleId = await AuthService().readCicleId();
    final url = Uri.http(
        _baseUrl, '/public/api/teachers/$cicleId/studentsWithCompletedTasks');
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
    var perfilP = PerfilProf.fromJson(decodedResp);
    for (var i in perfilP.students!) {
      estudiantesProf.add(i);
    }
    isLoading = false;
    notifyListeners();
    return perfilP;
  }

  recuperarPerfil() async {
    String? token = await AuthService().readToken();
    String? cicleId = await AuthService().readCicleId();
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
    var allProfesores = Profesores.fromJson(decodedResp);

    for (var i in allProfesores.profesores!) {
      if (i.cicleId.toString() == cicleId) {
        profesor.add(i);
      }
    }
    isLoading = false;
    notifyListeners();
    return profesor;
  }
}
