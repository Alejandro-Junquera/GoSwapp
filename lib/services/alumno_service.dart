import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class AlumnoService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  final List<TareaDelCiclo> tareasUser = [];
  bool isLoading = true;

  getCiclos() async {
    tareasUser.clear();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/cicles', {});

    final resp = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Some token"
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    isLoading = false;
    notifyListeners();

    return;
  }
}
