// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Task {
  final String description;
  final int id;
  late int status;
  final String title;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.status});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        status: json['status']);
  }

  @override
  String toString() {
    // TODO: implement toString

    return "{\"id\":${this.id},\"description\":\"${this.description.replaceAll('\n', '\\n').replaceAll(r'\', r'\\')}\",\"status\":${this.status},\"title\":\"${this.title}\"}";
  }
}
