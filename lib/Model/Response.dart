// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_new, unnecessary_this

import 'package:login_ui/Model/Task.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Response {
  final String projetBossFirstName;
  final String projetBossLastName;
  final int idBoss;
  final String projetTitle;
  final String projetDescription;
  final int idProjet;
  final List<Task> Tasks;
  final String token;
  //to creect type error dynamic beacause we can get tasks as List so we need to decode it to json

  Response(
      {required this.idBoss,
      required this.idProjet,
      required this.projetBossFirstName,
      required this.projetBossLastName,
      required this.projetDescription,
      required this.projetTitle,
      required this.Tasks,
      required this.token});

  factory Response.fromJson(Map<String, dynamic> json) {
    //Fix fromJson Error for list of tasks
    List<Task> resultTasks = [];
    for (var item in json['Tasks']) {
      resultTasks.add(new Task(
          id: item["id"],
          title: item["title"],
          description: item["description"],
          status: item["status"]));
    }

    return Response(
      idBoss: json['projet_boss_id'],
      idProjet: json['projet_id'],
      projetBossFirstName: json['projet_boss_firstName'],
      projetBossLastName: json['projet_boss_lastName'],
      projetDescription: json['projet_description'],
      projetTitle: json['projet_title'],
      Tasks: resultTasks,
      token: json['token'],
    );
  }

  factory Response.fromJsonSame(Map<String, dynamic> json) {
    //Fix fromJson Error for list of tasks
    List<Task> resultTasks = [];
    for (var item in json['Tasks']) {
      resultTasks.add(new Task(
          id: item["id"],
          title: item["title"],
          description: item["description"],
          status: item["status"]));
    }

    return Response(
      idBoss: json['idBoss'],
      idProjet: json['idProjet'],
      projetBossFirstName: json['projetBossFirstName'],
      projetBossLastName: json['projetBossLastName'],
      projetDescription: json['projetDescription'],
      projetTitle: json['projetTitle'],
      Tasks: resultTasks,
      token: json['token'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{\"idBoss\": ${this.idBoss},\"idProjet\": ${this.idProjet},\"projetBossFirstName\": \"${this.projetBossFirstName.toString()}\", \"projetBossLastName\": \"${this.projetBossLastName}\",\"projetDescription\": \"${this.projetDescription.replaceAll('\n', '\\n').replaceAll(r'\', r'\\')}\",\"projetTitle\": \"${this.projetTitle}\",\"Tasks\": ${this.Tasks},\"token\": \"${this.token}\"}";
  }
}
