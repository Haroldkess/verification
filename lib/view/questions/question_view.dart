import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/backoffice/api_url.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/view/widget/yes_or_no.dart';

import '../../model/question_model.dart';
import '../widget/quest_form.dart';
import '../widget/text.dart';

class QuestionView extends StatelessWidget {
  final String? q;
  QuestionController? controller;
  QuestionView({super.key, this.q, this.controller});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ExpansionTileCardState> card = GlobalKey();
    return GetBuilder(
        init: ReportController(),
        builder: (report) {
          return Column(
            children: [
              ObxValue((questions) {
                final thisQuestions = questions
                    .where((element) =>
                        element.category.toString().toLowerCase() ==
                        q!.toLowerCase())
                    .where((element) =>
                        element.questionlevel.toString().toLowerCase() ==
                        report.level.value.toLowerCase())
                    .where((element) =>
                        element.collectionstage.toString().toLowerCase() ==
                        report.type.value.toLowerCase())
                    .toList();

                return ExpansionTileCard(
                    //  key: card,
                    elevation: 0,
                    onExpansionChanged: (change) {
                      consoleLog(change.toString());
                    },
                    baseColor: Colors.white,
                    expandedColor: Colors.white.withOpacity(.6),
                    contentPadding: EdgeInsets.zero,
                    title: AppText(
                      text: q ?? "",
                      size: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    children: List.generate(
                        thisQuestions.length,
                        (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: thisQuestions[index].fieldtype.toString() ==
                                    "Y/N"
                                ? YesOrNo(
                                    id: thisQuestions[index].id!,
                                    question: thisQuestions[index].label,
                                  )
                                : QuestionForm(
                                    isDate: thisQuestions[index]
                                                .fieldtype
                                                .toString() ==
                                            "Date"
                                        ? true
                                        : false,
                                    id: thisQuestions[index].id!,
                                    textInputType: thisQuestions[index]
                                                .fieldtype
                                                .toString() ==
                                            "Number"
                                        ? TextInputType.number
                                        : thisQuestions[index]
                                                    .fieldtype
                                                    .toString() ==
                                                "Text"
                                            ? TextInputType.text
                                            : TextInputType.multiline,
                                    question: thisQuestions[index].label,
                                  ))));
              }, QuestionController.instance.questions)
            ],
          );
        });
  }
}
