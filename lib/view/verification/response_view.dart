import 'package:flutter/material.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/model/verification_model.dart';
import 'package:verification/view/verification/verification_details.dart';
import 'package:verification/view/widget/allNavigation.dart';
import 'package:verification/view/widget/text.dart';

class ResponseView extends StatelessWidget {
  final Response r;
  const ResponseView({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 60,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "${r.key}: ",
                    size: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(
                    child: AppText(
                      text: "${r.label}",
                      size: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              AppText(
                text: "${r.value}",
                size: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          //    color: Colors.amber,
        ),
        Divider()
      ],
    );
  }
}
