import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CiclosService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8000';
  final storage = const FlutterSecureStorage();
  List<CiclosData> ciclos = [];

  Future<List<CiclosData>> getCiclos() async {
    final url = Uri.http(_baseUrl, '/api/cicles', {});

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

    return ciclos;
  }
}
