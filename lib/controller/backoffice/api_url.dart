import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../view/widget/notification.dart';

class Api {
  static const baseUrl = "https://api.retool.com/v1/workflows/";

  static const verificationApi =
      "e567cec3-5851-4a3e-ada9-c93e84bc8abb/startTrigger?workflowApiKey=retool_wk_6ec1e4abc98940838a23d5a15537163c";

  static const questionApi =
      "9f5babf7-1a21-44dd-a101-4fcd314abae2/startTrigger?workflowApiKey=retool_wk_b9f34b1ae4cb497ebfe92fb34e7c0f53";

  static const createNewVerificationApi =
      "871e3eba-160c-4b8d-aa4a-5a4679e699f4/startTrigger?workflowApiKey=retool_wk_acf0557332914948bf6483c26b04d444";

  static const updateVerificatioApi =
      "4c38116b-b38e-4943-a2d3-7587487537fe/startTrigger?workflowApiKey=retool_wk_3514dbdef2d14fc98a65aeb846c44b10";

  static const cloudFareImageUploadApi =
      " https://api.cloudflare.com/client/v4/accounts/f3cf0f0442de28182c41a584b8e5cd7c/images/v1";
}

String header = "application/json";

class RequestData {
  static Future<http.Response?> postApi([
    String? url,
    String? token,
    dynamic body,
  ]) async {
    http.Response? response;
    try {
      if (token == null) {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
              },
              body: body == null ? null : jsonEncode(body.toJson()),
            )
            .timeout(const Duration(seconds: 20));
      } else {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                //   'Content-Type': 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
              body: body == null ? null : jsonEncode(body.toJson()),
            )
            .timeout(const Duration(seconds: 20));
      }

      log(response.body);
    } on TimeoutException {
      response = null;
      showBanner("Error occured", "Timeout: Please try again");
    } on PlatformException {
      response = null;
      showBanner("Error occured", "Platform exception: Please try again");
    } on Exception catch (e) {
      response = null;
      showBanner("Error occured", "Detail: ${e.toString()}");
    } catch (e) {
      response = null;
      showBanner(
          "Error occured", "Detail: Something went wrong Please try again");
      consoleLog(e.toString());
    }
    return response;
  }

  static Future<http.Response?> getApi([
    String? url,
    String? token,
  ]) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      consoleLog(response.body);
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future put() async {}

  static Future delete() async {}
}

void consoleLog(String val) {
  return debugPrint(val);
}
