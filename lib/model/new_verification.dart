// To parse this JSON data, do
//
//     final newVerificationModel = newVerificationModelFromJson(jsonString);

import 'dart:convert';

NewVerificationModel newVerificationModelFromJson(String str) =>
    NewVerificationModel.fromJson(json.decode(str));

String newVerificationModelToJson(NewVerificationModel data) =>
    json.encode(data.toJson());

class NewVerificationModel {
  dynamic insertId;

  NewVerificationModel({
    this.insertId,
  });

  factory NewVerificationModel.fromJson(Map<String, dynamic> json) =>
      NewVerificationModel(
        insertId: json["insert_id"],
      );

  Map<String, dynamic> toJson() => {
        "insert_id": insertId,
      };
}
