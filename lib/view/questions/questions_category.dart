import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
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
        Container(
          width: double.infinity,
          height: 50,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  reportModal(context, true, [
                    'field',
                    'farm',
                  ]);
                },
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border.all(
                          width: 2.0,
                          color: Colors.green,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(6)),
                  child: ObxValue((value) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 15,
                        ),
                        AppText(
                          text: " ${value.value ?? ""}",
                          color: Colors.green,
                        ),
                      ],
                    );
                  }, ReportController.instance.level),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              InkWell(
                onTap: () {
                  reportModal(context, false, [
                    'pre-visit',
                    'on-visit',
                    'post-visit',
                    'verifier-Visit',
                    'lab-Test'
                  ]);
                },
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border.all(
                          width: 2.0,
                          color: Colors.green,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(6)),
                  child: ObxValue((value) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.green,
                          size: 15,
                        ),
                        AppText(
                          text: " ${value.value ?? ""}",
                          color: Colors.green,
                        ),
                      ],
                    );
                  }, ReportController.instance.type),
                ),
              )
            ],
          ),
        ),
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
