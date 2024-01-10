import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/view/widget/button.dart';
import 'package:verification/view/widget/notification.dart';
import 'package:verification/view/widget/quest_form.dart';
import '../../controller/network_calls/create_new_verification.dart';
import '../questions/question_screen.dart';
import '../widget/allNavigation.dart';
import '../widget/text.dart';

reportModal(BuildContext cont, bool isLevel, List<String> options) async {
  return showModalBottomSheet(
      context: cont,
      isScrollControlled: true,
      //  backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            //  color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                        children: options
                            .map((e) => InkWell(
                                  onTap: () async {
                                    if (isLevel == true) {
                                      ReportController.instance.addLevel(e);
                                    } else {
                                      ReportController.instance.addType(e);
                                    }

                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) async {
                                      final thisQuestions = QuestionController
                                          .instance.questions
                                          .where((element) =>
                                              element.questionlevel
                                                  .toString()
                                                  .toLowerCase() ==
                                              ReportController
                                                  .instance.level.value
                                                  .toLowerCase())
                                          .where((element) =>
                                              element.collectionstage
                                                  .toString()
                                                  .toLowerCase() ==
                                              ReportController
                                                  .instance.type.value
                                                  .toLowerCase())
                                          .toList();
                                      QuestionController.instance
                                          .categoryList(thisQuestions, true);
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        children: [
                                          AppText(
                                            text: e,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()))
              ],
            ),
          ),
        );
      });
}
