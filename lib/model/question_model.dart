// To parse this JSON data, do
//
//     final verificationModel = verificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<QuestionModel> questionModelFromJson(String str) =>
    List<QuestionModel>.from(
        json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questioinModelToJson(List<QuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel {
  int? id;
  dynamic qNumber;
  dynamic category;
  dynamic ecosystem;
  dynamic questionlevel;
  dynamic collectionstage;
  dynamic sublevel;
  dynamic fieldtype;
  dynamic label;
  dynamic readOnlyWhen;
  RxList<String>? answer = <String>[].obs;

  QuestionModel({
    this.id,
    this.qNumber,
    this.category,
    this.ecosystem,
    this.questionlevel,
    this.collectionstage,
    this.sublevel,
    this.fieldtype,
    this.label,
    this.readOnlyWhen,
    this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        qNumber: json["qNumber"],
        category: json["category"],
        ecosystem: json["ecosystem"],
        questionlevel: json["questionlevel"],
        collectionstage: json["collectionstage"],
        sublevel: json["sublevel"],
        fieldtype: json["fieldtype"],
        label: json["label"],
        readOnlyWhen: json["read_only_when"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qNumber": qNumber,
        "category": category,
        "ecosystem": ecosystem,
        "questionlevel": questionlevel,
        "collectionstage": collectionstage,
        "sublevel": sublevel,
        "fieldtype": fieldtype,
        "label": label,
        "read_only_when": readOnlyWhen,
      };
}
