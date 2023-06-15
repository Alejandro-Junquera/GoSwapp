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

  bool editProfile = false;
  AlumnoPerfilData? alumnoAEditar;

  isEditable() {
    if (editProfile == false) {
      editProfile = true;
    } else {
      editProfile = false;
    }
    notifyListeners();
  }

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
        alumnoAEditar = i;
      }
    }
    isLoading = false;
    notifyListeners();
    return perfil;
  }

  actualizarAlumno(String firstname, String surname, String email,
      String mobile, String address) async {
    String? token = await AuthService().readToken();
    String? id = await AuthService().readId();
    print(id);
    final Map<String, dynamic> actualizarAlumno = {
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
      body: json.encode(actualizarAlumno),
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    isLoading = false;
    notifyListeners();
    if (decodedResp['message'] == null) {
      return 1;
    } else {
      return 0;
    }
  }
}
