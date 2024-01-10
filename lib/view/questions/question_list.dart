import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/view/verification/verification_view.dart';
import 'package:verification/view/widget/loader.dart';

import '../../model/verification_model.dart';
import 'question_view.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
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
                        itemCount: q.questions.length,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(8.0),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: QuestionView(
                                  //   q: q.questions[index],
                                  ));
                        }),
                  );
          }, QuestionController.instance.isLoading);
        });
  }
}
