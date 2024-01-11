import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verification/controller/network_calls/create_new_verification.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/model/verification_model.dart';
import '../../model/new_verification.dart';
import '../backoffice/api_url.dart';
import '../backoffice/db.dart';
import '../temps/temp_store.dart';

class Answers {
  String? number;
  String? question;
  String? value;
  String? note;
  String? image;
  Answers(this.number, this.question, this.value, this.note, this.image);

  @override
  String toString() {
    return '{ ${this.number}, ${this.question}, ${this.value} , ${this.note}, ${this.image} }';
  }
}

class UpdateVerificationCall {
  static Future makeRequest(context) async {
    String url = Api.baseUrl + Api.updateVerificatioApi;
    List<Answers> maps = [];

    await Future.forEach(QuestionController.instance.questions, (element) {
      maps.add(Answers(
          element.qNumber,
          element.label,
          element.answer == null ? null : element.answer!.first,
          element.notes == null ? null : element.notes!.first,
          element.image == null ? null : element.image!.first));
    });

    var map = Map.fromIterable(maps,
        key: (e) => e.number,
        value: (e) => {
              'label': e.question,
              'value': e.value,
              'notes': e.note,
              'media': [e.media]
            });

    UpdateModel body = UpdateModel(
        status: "submitted",
        response: map,
        id: CreateNewVerificationController
            .instance.newVerification.value.insertId);

    consoleLog(body.toJson().toString());
    UpdateVerificationController.instance.load(true);

    http.Response? response = await RequestData.postApi(url, null, body);
    if (response == null) {
      consoleLog("null");
    } else if (response.statusCode == 200) {
      consoleLog("here 200");

      try {
        await VerificationCall.makeRequest(context)
            .whenComplete(() => Get.back());
      } catch (e) {
        consoleLog(e.toString());
      }
    } else {
      consoleLog("others");
    }

    UpdateVerificationController.instance.load(false);
  }
}

class UpdateVerificationController extends GetxController {
  static UpdateVerificationController get instance {
    return Get.find<UpdateVerificationController>();
  }

  RxBool isLoading = false.obs;
  Rx newVerification = NewVerificationModel().obs;
  Future<void> addNewInsetIdData(NewVerificationModel data) async {
    newVerification.value = data;
  }

  void load(bool data) {
    isLoading.value = data;
  }
}

class UpdateModel {
  String? status;
  dynamic response;
  int? id;

  UpdateModel({
    this.status,
    this.response,
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": response,
        "id": id,
      };
}
