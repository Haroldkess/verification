import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verification/model/question_model.dart';
import 'package:verification/model/verification_model.dart';

import '../backoffice/api_url.dart';
import '../backoffice/db.dart';
import '../temps/temp_store.dart';

class QuestionCall {
  static Future makeRequest(context) async {
    String url = Api.baseUrl + Api.questionApi;
//    VerificationController verification = Provider.of(context, listen: false);
    SharedPreferences pref = await TempStore.pref();
    QuestionController.instance.load(true);

    if (pref.containsKey(TempStore.tokenKey)) {
      //var data = await Database.read(Database.userKey);
      // consoleLog(data.toString());
      // var decode = await jsonDecode(jsonEncode(data));
      // var existingData = ShopModel.fromJson(decode);
      // login.createShop(existingData);

      // pref.setBool(TempStore.isLoggedInKey, true);

      //    log(existingData.data!.user!.username.toString());
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
        var incomingData = questionModelFromJson(response.body);

        QuestionController.instance.addQuestionData(incomingData);

        Database.create(Database.questionKey, jsonData)
            .whenComplete(() => consoleLog("Questions stored in db"));

        // var data = await Database.read(Database.userKey);
        // var decode = await jsonDecode(jsonEncode(data));
        //var existingData = ShopModel.fromJson(decode);
        // login.createShop(existingData);
        // TempStore.storeToken(login.shopModel.data!.token);
      } else {
        consoleLog("others");
        //  var jsonData = jsonDecode(response.body);

        //   showBanner(jsonData["message"], red, context);
      }
    }
    QuestionController.instance.load(false);
  }
}

class QuestionController extends GetxController {
  static QuestionController get instance {
    return Get.find<QuestionController>();
  }

  RxBool isLoading = false.obs;
  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  RxList category = <String>[].obs;
  Future<void> addQuestionData(List<QuestionModel> data) async {
    questions.value = data;
    await categoryList(data);
  }

  Future<void> categoryList(List<QuestionModel> data, [bool? isNew]) async {
    if (isNew == true) {
      category.value = <String>[];
      await Future.forEach(data, (element) async {
        if (category.contains(element.category)) {
          //  category.add(element.category);
        } else {
          category.add(element.category);
        }
      });
      consoleLog("Done");
    } else {
      await Future.forEach(data, (element) {
        if (category.contains(element.category)) {
        } else {
          category.add(element.category);
        }
      });
    }

    update();
  }

  void addAnswer(String data, int id) async {
    List lister = questions.where((p0) => p0.id == id).toList();
    if (lister.isNotEmpty) {
      questions.where((p0) => p0.id == id).first.answer = [""].obs;
      questions.where((p0) => p0.id == id).first.answer!.clear();
      questions.where((p0) => p0.id == id).first.answer!.add(data);
      consoleLog(questions.where((p0) => p0.id == id).first.answer!.first);
    }
    update();
  }

  void load(bool data) {
    isLoading.value = data;
  }
}
