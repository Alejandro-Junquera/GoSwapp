// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'goswapp.allsites.es';
  final storage = const FlutterSecureStorage();

  Future<String?> register(String name, String surname, String email,
      String password, String type, int cicle_id) async {
    final Map<String, dynamic> authData = {
      'firstname': name,
      'surname': surname,
      'email': email,
      'type': type,
      'password': password,
      'cicle_id': cicle_id
    };
    final url = Uri.http(_baseUrl, '/api/register', {});

    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp['error'] != null) {
      return decodedResp['error']['email'].toString();
    }
    return null;
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.http(_baseUrl, '/public/api/login', {});

    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp['success'] != null) {
      await storage.write(key: 'token', value: decodedResp['success']['token']);
      await storage.write(
          key: 'userId', value: decodedResp['success']['id'].toString());
      return decodedResp['success']['userType'];
    } else {
      return decodedResp['error'];
    }
  }

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'userId') ?? '';
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
