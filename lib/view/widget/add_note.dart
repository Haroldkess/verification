import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/view/widget/quest_form.dart';
import 'package:verification/view/widget/text.dart';

import '../../controller/network_calls/question_call.dart';
import 'button.dart';

addNoteModal(
  BuildContext cont,
  int id,
) async {
  return showModalBottomSheet(
      context: cont,
      isScrollControlled: true,
      //  backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            //  color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ObxValue((q) {
                List check = q.where((p0) => p0.id == id).first.notes ?? [];
                List checkImage =
                    q.where((p0) => p0.id == id).first.image ?? [];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    AppText(text: "Add details"),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => Operations.pickForPost(context),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Icon(
                                  Icons.image_search,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppForm(
                            title: "Note",
                            isNote: true,
                            initValue: check.isEmpty ? "" : check.first,
                            id: id,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppButton(
                              text: "Okay",
                              onTap: () {
                                Get.back();
                              }),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }, QuestionController.instance.questions),
            ),
          ),
        );
      });
}
