import 'package:flutter/material.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/model/verification_model.dart';
import 'package:verification/view/verification/verification_details.dart';
import 'package:verification/view/widget/allNavigation.dart';
import 'package:verification/view/widget/text.dart';

class VerificationView extends StatelessWidget {
  final VerificationModel v;
  const VerificationView({super.key, required this.v});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PageRouting.pushToPage(context, VerificationDetails(v: v));
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: Operations.times(v.createdAt ?? DateTime.now()),
                      size: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    AppText(
                      text: "Auto Saved",
                      size: 10,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "Open",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            //    color: Colors.amber,
          ),
          Divider()
        ],
      ),
    );
  }
}
