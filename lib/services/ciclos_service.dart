import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CiclosService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  final storage = const FlutterSecureStorage();
  List<CicloData> ciclos = [];
  bool isLoading = true;

  getCiclos() async {
    ciclos.clear();
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
    var ciclo = Ciclos.fromJson(decodedResp);
    print(decodedResp);

    for (var i in ciclo.ciclos!) {
      ciclos.add(i);
    }
    isLoading = false;
    notifyListeners();

    return ciclos;
  }
}
