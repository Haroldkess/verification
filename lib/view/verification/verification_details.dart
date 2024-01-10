import 'package:flutter/material.dart';
import 'package:verification/view/verification/response_view.dart';

import '../../model/verification_model.dart';
import '../widget/text.dart';

class VerificationDetails extends StatelessWidget {
  final VerificationModel v;
  const VerificationDetails({super.key, required this.v});

  @override
  Widget build(BuildContext context) {
    List<Response> responseData = v.response!.entries
        .map((entry) => Response(
              key: entry.key,
              label: entry.value.label,
              value: entry.value.value,
            ))
        .toList();
    //   consoleLog(weightData.first.key!);
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Verification Response",
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: responseData.length,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: ResponseView(r: responseData[index]),
            );
          }),
    );
  }
}
