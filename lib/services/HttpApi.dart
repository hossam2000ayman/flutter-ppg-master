// ignore_for_file: file_names, unused_import, prefer_const_constructors, curly_braces_in_flow_control_structures
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_ui/Exception/EmailException.dart';
import 'package:login_ui/Exception/PasswordException.dart';
import 'package:login_ui/Exception/ServerException.dart';
import 'package:login_ui/Model/Response.dart';

class HttpApi {
  static const apiUrl =
      "http://10.0.2.2:5000/api/"; //localhost mean somthing different on real device so to access the host machine we need this ip(10.0.2.2)
  static Future<Response> loginEmployee(
      String emailAccount, String passwordAccout) async {
    Map dataToPost = {'email': emailAccount, 'password': passwordAccout};
    final http.Response response = await http.post(
      Uri.parse(apiUrl + "login"),
      body: json.encode(dataToPost),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 500) {
      throw ServerException('Failed to load API');
    } else if (response.statusCode == 401) {
      if (jsonDecode(response.body)["email"] == true)
        throw EmailException("Invalid Email");

      if (jsonDecode(response.body)["password"] == true)
        throw PasswordException("Invalid Password!");
    }

    return Response.fromJson(jsonDecode(response.body));
  }

  static Future<void> validTask(int idTask, String token) async {
    Map<String, int> dataPost = {'id': idTask};
    final http.Response response = await http.post(
      Uri.parse(apiUrl + "edit"),
      body: json.encode(dataPost),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      },
    );

    if (response.statusCode != 200) throw Exception('somthing wrong');
  }
}
