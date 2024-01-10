// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  Result? result;
  dynamic resultInfo;
  bool? success;
  List<dynamic>? errors;
  List<dynamic>? messages;

  ImageModel({
    this.result,
    this.resultInfo,
    this.success,
    this.errors,
    this.messages,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        resultInfo: json["result_info"],
        success: json["success"],
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]!.map((x) => x)),
        messages: json["messages"] == null
            ? []
            : List<dynamic>.from(json["messages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "result_info": resultInfo,
        "success": success,
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "messages":
            messages == null ? [] : List<dynamic>.from(messages!.map((x) => x)),
      };
}

class Result {
  String? id;
  String? filename;
  DateTime? uploaded;
  bool? requireSignedUrLs;
  List<String>? variants;

  Result({
    this.id,
    this.filename,
    this.uploaded,
    this.requireSignedUrLs,
    this.variants,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        filename: json["filename"],
        uploaded:
            json["uploaded"] == null ? null : DateTime.parse(json["uploaded"]),
        requireSignedUrLs: json["requireSignedURLs"],
        variants: json["variants"] == null
            ? []
            : List<String>.from(json["variants"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "uploaded": uploaded?.toIso8601String(),
        "requireSignedURLs": requireSignedUrLs,
        "variants":
            variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
      };
}
