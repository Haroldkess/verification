import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/view/questions/question_filter.dart';
import 'package:verification/view/verification/report_modal.dart';
import 'package:verification/view/verification/verification_view.dart';
import 'package:verification/view/widget/loader.dart';
import 'package:verification/view/widget/text.dart';

import '../../model/verification_model.dart';
import '../widget/button.dart';
import 'question_view.dart';

class QuestionsCategory extends StatelessWidget {
  const QuestionsCategory({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ObxValue((load) {
          return Visibility(
              visible: load.value ? false : true, child: QuestionFilter());
        }, QuestionController.instance.isLoading),
        Expanded(
          child: GetBuilder(
              init: QuestionController(),
              builder: (q) {
                //       RxList peopleChat = v.verifications
                // ..sort((a, b) => b.
                //     .compareTo(a.conversations!.first.updatedAt!));
                return ObxValue((load) {
                  return load.value
                      ? Center(child: Loader())
                      : Visibility(
                          visible: load.value ? false : true,
                          child: ListView.builder(
                              itemCount: q.category.length,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 100),
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: QuestionView(
                                      q: q.category[index],
                                      controller: q,
                                    ));
                              }),
                        );
                }, QuestionController.instance.isLoading);
              }),
        ),
      ],
    );
  }
}
