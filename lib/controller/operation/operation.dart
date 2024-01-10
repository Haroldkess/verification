import 'dart:io';

import 'package:advance_image_picker/models/image_object.dart';
import 'package:advance_image_picker/widgets/picker/image_picker.dart';
import 'package:cloudflare/cloudflare.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/backoffice/api_url.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/view/home/home.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../main.dart';
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

  static Future pickForPost(BuildContext context) async {
    late Cloudflare cloudflare;
    try {
      cloudflare = Cloudflare(
        apiUrl: apiUrl,
        accountId: accountId,
        token: token,
        apiKey: apiKey,
        accountEmail: accountEmail,
        userServiceKey: userServiceKey,
      );
      await cloudflare.init();
    } catch (e) {
      cloudflareInitMessage = '''
    Check your environment definitions for Cloudflare.
    Make sure to run this app with:  
    
    flutter run
    --dart-define=CLOUDFLARE_API_URL=https://api.cloudflare.com/client/v4
    --dart-define=CLOUDFLARE_ACCOUNT_ID=xxxxxxxxxxxxxxxxxxxxxxxxxxx
    --dart-define=CLOUDFLARE_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxx
    --dart-define=CLOUDFLARE_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxx
    --dart-define=CLOUDFLARE_ACCOUNT_EMAIL=xxxxxxxxxxxxxxxxxxxxxxxxxxx
    --dart-define=CLOUDFLARE_USER_SERVICE_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxx
    
    Exception details:
    ${e.toString()}
    ''';
      print(e);
    }
    // Cloudflare cloudflare = Cloudflare(
    //   accountId: "f3cf0f0442de28182c41a584b8e5cd7c",
    //   token: "YhGxUEPSGO_9O_k9xf3F6ImE-9c8PI-qkwKcrcgA",
    // );
    cloudflare = Cloudflare.basic(apiUrl: Api.cloudFareImageUploadApi);
    try {
      //Initialize both [CreatePost] && [UserProfile] State
      // CreatePostWare picked =
      //     Provider.of<CreatePostWare>(context, listen: false);

      final List<ImageObject>? objects = await Navigator.of(context)
          .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
        return const ImagePicker(
          maxCount: 1,
        );
      }));

      if (objects == null) return;
      if ((objects.length ?? 0) < 1) return;

      //Converts result into usable file
      List<File> recievedFiles = [];
      for (ImageObject imageObject in objects) {
        recievedFiles.add(File(imageObject.modifiedPath));
      }

      //From file
      CloudflareHTTPResponse<CloudflareImage?> responseFromFile =
          await cloudflare.imageAPI.upload(
              contentFromFile: DataTransmit<File>(
                  data: recievedFiles.first,
                  progressCallback: (count, total) {
                    print('Upload progress: $count/$total');
                  }));

      if (responseFromFile.isSuccessful) {
        consoleLog("good");
      } else {
        consoleLog("bad");
      }
      //  emitter(file.first.path.toString());
      //  picked.addFile(recievedFiles);

      // ignore: use_build_context_synchronously
      // PageRouting.pushToPage(context, const CreatePostScreen());
    } catch (e) {
      consoleLog(e.toString());
      //Display error to user
      // ignore: use_build_context_synchronously
      //showToast2(context, "Oops!! ${e.toString()}", isError: true);
      return;
    }
  }
}
