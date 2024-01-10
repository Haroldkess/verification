import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/verification_call.dart';
import 'package:verification/view/verification/verification_view.dart';
import 'package:verification/view/widget/loader.dart';

import '../../model/verification_model.dart';
import '../widget/skeleton_loading.dart';

class VerificalionList extends StatelessWidget {
  const VerificalionList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: VerificationController(),
        builder: (v) {
          RxList verification = v.verifications
            ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          return ObxValue((load) {
            return load.value
                ? SkeletonLoader()
                : Visibility(
                    visible: load.value ? false : true,
                    child: ListView.builder(
                        itemCount: v.verifications.length,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(8.0),
                        //  reverse: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: VerificationView(v: verification[index]),
                          );
                        }),
                  );
          }, VerificationController.instance.isLoading);
        });
  }
}
