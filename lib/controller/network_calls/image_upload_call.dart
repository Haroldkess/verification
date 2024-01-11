import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verification/controller/backoffice/api_url.dart';

class ImageUplloadCall {
  static Future<http.StreamedResponse?> makeRequest(File image) async {
    http.StreamedResponse? response;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = Api.cloudToken;
    final filePhotoName = basename(image.path);
    var request =
        http.MultipartRequest("POST", Uri.parse(Api.cloudFareImageUploadApi));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    };

    var filePhoto = await http.MultipartFile.fromPath('id', image.path,
        filename: filePhotoName);

    request.headers.addAll(headers);

    request.files.add(filePhoto);

    try {
      response = await request.send();
    } catch (e) {
      //   log("hello");
      //   log(e.toString());
      response = null;
    }

    return response;
  }
}
