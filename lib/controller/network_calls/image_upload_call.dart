import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verification/controller/backoffice/api_url.dart';
import 'dart:math' as rand;

class ImageUplloadCall {
  static Future<http.StreamedResponse?> makeRequest(File image, int id) async {
    http.StreamedResponse? response;
    String r = rand.Random().nextInt(999999).toString().padLeft(5, '0');

    final finalId =
        "${DateTime.now().microsecondsSinceEpoch}$r$id${image.path}";
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = Api.cloudToken;
    final filePhotoName = basename(image.path);
    var request =
        http.MultipartRequest("POST", Uri.parse(Api.cloudFareImageUploadApi));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    };

    var filePhoto = await http.MultipartFile.fromPath('file', image.path,
        filename: filePhotoName);

    request.headers.addAll(headers);

    request.files.add(filePhoto);
    request.fields["id"] = finalId.toString();

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
