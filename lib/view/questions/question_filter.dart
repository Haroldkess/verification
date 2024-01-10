import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/network_calls/report_controller.dart';
import '../verification/report_modal.dart';
import '../widget/text.dart';

class QuestionFilter extends StatelessWidget {
  const QuestionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
