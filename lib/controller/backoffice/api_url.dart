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
      "043c585a-4a4d-4072-97dc-3323a45b50bd/startTrigger?workflowApiKey=retool_wk_67a2ab734f5b437d981cd639ea0decda";

  static const questionApi =
      "9baa35ff-76b0-470a-ac67-ac39ea6e6789/startTrigger?workflowApiKey=retool_wk_94ef3700c90445e3ac6bd586b5c9ddd2";

  static const createNewVerificationApi =
      "58d9d3ca-4c03-43da-8dd5-bac0e85d6992/startTrigger?workflowApiKey=retool_wk_a7410512bd674d8492a5c0c3046a0316";

  static const updateVerificatioApi =
      "f0377c07-e738-494f-a5ae-7be9e1330695/startTrigger?workflowApiKey=retool_wk_72393f760340412c9d0d7d36251b9d6e";

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
