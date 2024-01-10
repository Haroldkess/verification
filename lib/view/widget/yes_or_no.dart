import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/backoffice/api_url.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/view/widget/text.dart';

class YesOrNo extends StatelessWidget {
  final int id;
  final String? question;
  const YesOrNo({super.key, required this.id, this.question});

  @override
  Widget build(BuildContext context) {
    List<String> answers = ["N/A", "No", "Yes"];
    return Column(
      children: [
        Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              child: AppText(
                text: question ?? "",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.3),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: answers
                .map((e) => ObxValue((q) {
                      List check =
                          q.where((p0) => p0.id == id).first.answer ?? [];
                      //  consoleLog(check.toString());
                      return InkWell(
                        onTap: () {
                          QuestionController.instance.addAnswer(e, id);
                          FocusScope.of(context).unfocus();
                          //   Focus.of(context).unfocus();
                        },
                        child: Container(
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                              color: check.isEmpty
                                  ? Colors.transparent
                                  : check.first == e
                                      ? Colors.black
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: AppText(
                            text: e,
                            color: check.isEmpty
                                ? Colors.black
                                : check.first == e
                                    ? Colors.white
                                    : Colors.black,
                          )),
                        ),
                      );
                    }, QuestionController.instance.questions))
                .toList(),
          ),
        ),
      ],
    );
    ;
  }
}
