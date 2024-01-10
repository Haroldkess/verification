import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verification/model/verification_model.dart';

import '../backoffice/api_url.dart';
import '../backoffice/db.dart';
import '../temps/temp_store.dart';

class VerificationCall {
  static Future makeRequest(context) async {
    String url = Api.baseUrl + Api.verificationApi;
//    VerificationController verification = Provider.of(context, listen: false);
    SharedPreferences pref = await TempStore.pref();
    VerificationController.instance.load(true);

    if (pref.containsKey(TempStore.tokenKey)) {
    } else {
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
        var incomingData = verificationModelFromJson(response.body);
        VerificationController.instance.addVerificationData(incomingData);

        Database.create(Database.verificationKey, jsonData)
            .whenComplete(() => consoleLog("Verification stored in db"));

        // var data = await Database.read(Database.userKey);
        // var decode = await jsonDecode(jsonEncode(data));
      } else {
        consoleLog("others");
        //  var jsonData = jsonDecode(response.body);

        //   showBanner(jsonData["message"], red, context);
      }
    }
    VerificationController.instance.load(false);
  }
}

class VerificationController extends GetxController {
  static VerificationController get instance {
    return Get.find<VerificationController>();
  }

  RxBool isLoading = false.obs;
  RxList<VerificationModel> verifications = <VerificationModel>[].obs;
  Future<void> addVerificationData(List<VerificationModel> data) async {
    verifications.value = data;
  }

  void load(bool data) {
    isLoading.value = data;
  }
}
