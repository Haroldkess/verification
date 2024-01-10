import 'package:get/get.dart';

class ReportController extends GetxController {
  static ReportController get instance {
    return Get.find<ReportController>();
  }

  RxBool isLoading = false.obs;
  RxString type = "pre-visit".obs;
  RxString level = "field".obs;
  RxString fieldName = "".obs;

  RxString farmName = "".obs;

  Future<void> addType(data) async {
    type.value = data;
    update();
  }

  Future<void> addLevel(data) async {
    level.value = data;
    update();
  }

  Future<void> addFieldName(data) async {
    fieldName.value = data;
    update();
  }

  Future<void> addFarmName(data) async {
    farmName.value = data;
    update();
  }

  Future<void> clear() async {
    farmName.value = "";
    fieldName.value = "";
    update();
  }

  void load(bool data) {
    isLoading.value = data;
  }
}
