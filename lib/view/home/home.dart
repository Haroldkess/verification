import 'package:flutter/material.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/view/questions/question_screen.dart';
import 'package:verification/view/verification/report_modal.dart';
import 'package:verification/view/verification/verification_list.dart';
import 'package:verification/view/widget/allNavigation.dart';
import 'package:verification/view/widget/text.dart';

import '../../controller/network_calls/create_new_verification.dart';
import '../../controller/network_calls/report_controller.dart';
import '../report/report_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const VerificalionList(),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(),
        // Your actual Fab
        onPressed: () async {
          //  NewVerificationCall.makeRequest(context);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ReportController.instance.clear();
          });
          PageRouting.pushToPage(context, const ReportForm());

          // PageRouting.pushToPage(context, const QuestionScreen());
        },
        enableFeedback: true,
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppText(
          text: "Home",
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              VerificationCall.makeRequest(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.refresh_outlined,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
