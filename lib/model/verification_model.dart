// To parse this JSON data, do
//
//     final verificationModel = verificationModelFromJson(jsonString);

import 'dart:convert';

List<VerificationModel> verificationModelFromJson(String str) =>
    List<VerificationModel>.from(
        json.decode(str).map((x) => VerificationModel.fromJson(x)));

String verificationModelToJson(List<VerificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerificationModel {
  int? id;
  dynamic status;
  Map<String, Response>? response;
  DateTime? createdAt;
  String? createdBy;

  VerificationModel({
    this.id,
    this.status,
    this.response,
    this.createdAt,
    this.createdBy,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      VerificationModel(
        id: json["id"],
        status: json["status"],
        response: Map.from(json["response"])
            .map((k, v) => MapEntry<String, Response>(k, Response.fromJson(v))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "response": Map.from(response!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
      };
}

class Response {
  String? label;
  String? value;
  String? key;

  Response({
    this.label,
    this.value,
    this.key,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
