import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/model/verification_model.dart';
import '../../model/new_verification.dart';
import '../backoffice/api_url.dart';
import '../backoffice/db.dart';
import '../temps/temp_store.dart';

class NewVerificationCall {
  static Future makeRequest(context) async {
    String url = Api.baseUrl + Api.createNewVerificationApi;

    CreateNewVerificationController.instance.load(true);
    QuestionController.instance.load(true);

    http.Response? response = await RequestData.getApi(
      url,
      null,
    );
    if (response == null) {
      consoleLog("null");
    } else if (response.statusCode == 200) {
      consoleLog("here 200");
      //   consoleLog("successful");
      var jsonData = jsonDecode(response.body);
      var incomingData = NewVerificationModel.fromJson(jsonData);
      CreateNewVerificationController.instance.addNewInsetIdData(incomingData);
      QuestionCall.makeRequest(context);
    } else {
      consoleLog("others");
    }

    CreateNewVerificationController.instance.load(false);
  }
}

class CreateNewVerificationController extends GetxController {
  static CreateNewVerificationController get instance {
    return Get.find<CreateNewVerificationController>();
  }

  RxBool isLoading = false.obs;
  Rx<NewVerificationModel> newVerification = NewVerificationModel().obs;
  Future<void> addNewInsetIdData(NewVerificationModel data) async {
    newVerification.value = data;
  }

  void load(bool data) {
    isLoading.value = data;
  }
}
