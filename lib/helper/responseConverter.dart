// ignore: file_names

// ignore_for_file: file_names, unused_local_variable

import 'dart:convert';

import 'package:login_ui/Model/Response.dart';

Response convertStringToResponse(String storageText) {
  Map<String, dynamic> decodeStorage = jsonDecode(storageText);

  // print(decodeStorage.runtimeType);

  return Response.fromJsonSame(decodeStorage);
}
