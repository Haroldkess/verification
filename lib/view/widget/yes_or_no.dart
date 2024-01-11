import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/backoffice/api_url.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/view/widget/add.dart';
import 'package:verification/view/widget/add_note.dart';
import 'package:verification/view/widget/text.dart';

// widget for yes or no selection
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
            Expanded(
              child: AppText(
                text: question ?? "",
                fontWeight: FontWeight.bold,
                height: 0,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
        ObxValue((q) {
          List file = q.where((p0) => p0.id == id).first.file ?? [];
          List note = q.where((p0) => p0.id == id).first.notes ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              file.isEmpty && note.isEmpty
                  ? SizedBox.shrink()
                  : const SizedBox(
                      height: 5,
                    ),
              Row(
                children: [
                  file.isEmpty
                      ? SizedBox.shrink()
                      : CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              file.isEmpty ? null : FileImage(file.first),
                        ),
                  const SizedBox(
                    width: 3,
                  ),
                  note.isEmpty
                      ? SizedBox.shrink()
                      : note.first.isEmpty
                          ? SizedBox.shrink()
                          : Expanded(
                              child: AppText(
                              text: note.isEmpty ? "" : "Note: ${note.first}",
                              align: TextAlign.left,
                              color: Colors.grey,
                            ))
                ],
              ),
            ],
          );
        }, QuestionController.instance.questions),
        const SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                          List file =
                              q.where((p0) => p0.id == id).first.file ?? [];
                          //  consoleLog(check.toString());
                          return InkWell(
                            onTap: () {
                              QuestionController.instance.addAnswer(e, id);
                              FocusScope.of(context).unfocus();
                              consoleLog(question!.toString());
                              //   Focus.of(context).unfocus();
                            },
                            child: Container(
                              width: Get.width * 0.25,
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
            AddButton(
              onTap: () {
                addNoteModal(context, id);
              },
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
    ;
  }
}
