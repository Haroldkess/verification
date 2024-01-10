import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/update_verification_call.dart';
import 'package:verification/view/questions/question_list.dart';
import 'package:verification/view/questions/questions_category.dart';
import 'package:verification/view/widget/loader.dart';

import '../widget/text.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ObxValue((submit) {
        return FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          // Your actual Fab
          onPressed: () async {
            if (submit.value == false) {
              UpdateVerificationCall.makeRequest(context);
            }
          },
          enableFeedback: true,
          backgroundColor: Colors.black,
          label: submit.value
              ? Loader(
                  color: Colors.white,
                )
              : Visibility(
                  visible: submit.value ? false : true,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      AppText(
                        text: "Submit",
                        fontWeight: FontWeight.w900,
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
        );
      }, UpdateVerificationController.instance.isLoading),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppText(
          text: "Verification",
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: AppText(
              text: "Saved",
              fontWeight: FontWeight.w400,
              size: 13,
            ),
          )
        ],
      ),
      body: const QuestionsCategory(),
    );
  }
}
