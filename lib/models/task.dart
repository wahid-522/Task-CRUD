// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));


class Welcome {
  final String? docId;
  final String? title;
  final String? decripation;
  final String? userID;
  final String? priorityID;
  final String? image;
  final bool? isCompleted;
  final int? creatAt;

  Welcome({
    this.docId,
    this.title,
    this.decripation,
    this.userID,
    this.priorityID,
    this.image,
    this.isCompleted,
    this.creatAt, required String decription,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    docId: json["docId"],
    title: json["title"],
    decripation: json["decripation"],
    userID: json["userID"],
    priorityID: json["priorityID"],
    image: json["image"],
    isCompleted: json["isCompleted"],
    creatAt: json["creatAt"], decription: '',
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docId": taskID,
    "title": title,
    "decripation": decripation,
    "userID": userID,
    "priorityID": priorityID,
    "image": image,
    "isCompleted": isCompleted,
    "creatAt": creatAt,
  };
}
