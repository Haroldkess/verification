import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/view/home/home.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../view/widget/allNavigation.dart';
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
}
