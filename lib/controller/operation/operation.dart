import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:advance_image_picker/models/image_object.dart';
import 'package:advance_image_picker/widgets/picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/backoffice/api_url.dart';
import 'package:verification/controller/network_calls/image_upload_call.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/controller/operation/operation_ext.dart';
import 'package:verification/model/image_model.dart';
import 'package:verification/view/home/home.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:verification/view/widget/notification.dart';
import '../../main.dart';
import '../../view/widget/allNavigation.dart';
import 'package:http/http.dart' as http;
import '../network_calls/create_new_verification.dart';
import '../network_calls/question_call.dart';
import '../network_calls/update_verification_call.dart';

class Operations {
  static Future delayScreen(BuildContext context, Widget page) async {
    await Future.delayed(const Duration(seconds: 1), () {})
        .whenComplete(() => PageRouting.removeAllToPage(context, page));
  }

  static Future callData(context) async {
    VerificationCall.makeRequest(context)
        .whenComplete(() => delayScreen(context, MyHomePage()));
  }

  static Future initControllers() async {
    Get.put(VerificationController());
    Get.put(QuestionController());
    Get.put(CreateNewVerificationController());
    Get.put(UpdateVerificationController());
    Get.put(ReportController());
  }

  static String times(DateTime time) {
    late String realTime;

    String value = timeago.format(time).toString();
    String timeOfDay =
        TimeOfDay(hour: time.hour, minute: time.minute).period.name;

    if (value == "a moment ago") {
      realTime = "just now";
    } else if (value == "a minute ago") {
      realTime = value;
    } else if (value.contains("hour")) {
      realTime = "${value} ";
    } else if (value.contains("hours")) {
      realTime = "$value ";
    } else if (value == 'a day ago') {
      realTime = "yesterday";
    } else if (value.contains("days")) {
      realTime = "$value";
    } else {
      realTime = value;
    }

    if (realTime.contains("about")) {
      var val = realTime.split("about");

      realTime = val.last;
    }

    return realTime;
  }

  static Future pickForPost(BuildContext context, int id) async {
    try {
      final List<ImageObject>? objects = await Navigator.of(context)
          .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
        return const ImagePicker(
          maxCount: 1,
          isCaptureFirst: false,
        );
      }));

      if (objects == null) return;
      if ((objects.length ?? 0) < 1) return;

      //Converts result into usable file
      List<File> recievedFiles = [];
      for (ImageObject imageObject in objects) {
        recievedFiles.add(File(imageObject.modifiedPath));
      }
      final bytes = recievedFiles.first.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      // File finalFile = await OperationExt.compressAndGetFile(
      //     recievedFiles.first, "${recievedFiles.first.path}.jpg");
      log("${mb.toString()} MB");
      log("${kb.toString()} KB");

      QuestionController.instance.addFile(recievedFiles.first.path, id);

      //call api here to upload and get
      await uploadImage(recievedFiles.first, id);
    } catch (e) {
      consoleLog(e.toString());
      return;
    }
  }

// write code to upload and retrieve image
  static Future<void> uploadImage(File imageData, int id) async {
    //use existing  ImageModel(); to decode response
    QuestionController.instance.upload(true);
    try {
      http.StreamedResponse? response =
          await ImageUplloadCall.makeRequest(imageData, id);

      if (response == null) {
        consoleLog("null");
      } else if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        var jsonData = jsonDecode(res.body);
        var incomingData = ImageModel.fromJson(jsonData);
        consoleLog("done");
        //send  image url here after retrieving so it can save in ui and answer
        QuestionController.instance
            .addImage(incomingData.result!.variants!.first.toString(), id);
      } else {
        final res = await http.Response.fromStream(response);
        var jsonData = jsonDecode(res.body);
        showBanner("Failed", jsonData["errors"][0]["message"].toString());
        consoleLog("something else ${jsonData.toString()}");
      }
    } catch (e) {
      consoleLog(e.toString());
    }
    QuestionController.instance.upload(false);
  }
}
