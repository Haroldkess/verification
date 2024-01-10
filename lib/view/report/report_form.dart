import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/network_calls/create_new_verification.dart';
import '../../controller/network_calls/report_controller.dart';
import '../questions/question_screen.dart';
import '../widget/allNavigation.dart';
import '../widget/button.dart';
import '../widget/notification.dart';
import '../widget/quest_form.dart';
import '../widget/text.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  TextEditingController farmName = TextEditingController();
  TextEditingController fieldName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Report Form",
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              AppForm(
                title: "Name of farm",
                controller: farmName,
                isField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              AppForm(
                title: "Field name",
                controller: fieldName,
                isField: true,
              ),
              const SizedBox(
                height: 10,
              ),
              AppDropDownReport(
                onChange: (val) {},
              ),
              const SizedBox(
                height: 10,
              ),
              AppDropDown(
                onChange: (val) {},
              ),
              const SizedBox(
                height: 30,
              ),
              GetBuilder(
                  init: ReportController(),
                  builder: (report) {
                    return AppButton(
                        text: "Proceed",
                        onTap: () {
                          if (report.farmName.isEmpty ||
                              report.fieldName.isEmpty) {
                            showBanner("Incomplete Form ",
                                "Please fill report form properly");
                          } else {
                            NewVerificationCall.makeRequest(context);
                            PageRouting.pushToPage(
                                context, const QuestionScreen());
                          }
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
