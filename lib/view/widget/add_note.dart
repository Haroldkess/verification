import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/view/widget/allNavigation.dart';
import 'package:verification/view/widget/loader.dart';
import 'package:verification/view/widget/quest_form.dart';
import 'package:verification/view/widget/text.dart';

import '../../controller/network_calls/question_call.dart';
import 'button.dart';

String url =
    "https://icon-library.com/images/placeholder-image-icon/placeholder-image-icon-17.jpg";
addNoteModal(
  BuildContext cont,
  int id,
) async {
  return showModalBottomSheet(
      context: cont,
      isScrollControlled: true,
      isDismissible: false,
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
                child: GetBuilder(
                    init: QuestionController(),
                    builder: (question) {
                      return SingleChildScrollView(
                        child: Column(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ObxValue((q) {
                                List check =
                                    q.where((p0) => p0.id == id).first.notes ??
                                        [];
                                List image =
                                    q.where((p0) => p0.id == id).first.image ??
                                        [];
                                List file =
                                    q.where((p0) => p0.id == id).first.file ??
                                        [];
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: () =>
                                            Operations.pickForPost(context, id),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              image.isEmpty && file.isEmpty
                                                  ? SizedBox.shrink()
                                                  : image.isEmpty &&
                                                          file.isNotEmpty
                                                      ? Image.file(
                                                          file.first,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : image.isNotEmpty
                                                          ? Image.network(
                                                              image.first,
                                                              fit: BoxFit.cover)
                                                          : SizedBox.shrink(),
                                              Center(
                                                child: Icon(
                                                  Icons.image_search,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AppForm(
                                      title: "Note",
                                      isNote: true,
                                      initValue:
                                          check.isEmpty ? "" : check.first,
                                      id: id,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ObxValue((uploading) {
                                      return uploading.value
                                          ? Visibility(
                                              visible: uploading.value
                                                  ? uploading.value
                                                  : false,
                                              child: Loader())
                                          : Visibility(
                                              visible: uploading.value
                                                  ? false
                                                  : true,
                                              child: AppButton(
                                                  text: "Okay",
                                                  onTap: () {
                                                    QuestionController.instance
                                                        .reBuild();
                                                    Get.back();
                                                  }),
                                            );
                                    }, QuestionController.instance.uploading),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              }, QuestionController.instance.questions),
                            )
                          ],
                        ),
                      );
                    })),
          ),
        );
      });
}
