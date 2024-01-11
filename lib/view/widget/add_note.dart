import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/view/widget/allNavigation.dart';
import 'package:verification/view/widget/quest_form.dart';
import 'package:verification/view/widget/text.dart';

import '../../controller/network_calls/question_call.dart';
import 'button.dart';

final url =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019";
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => PageRouting.popToPage(context),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ))
                      ],
                    ),
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
                            onTap: () => Operations.pickForPost(context, id),
                            child: ObxValue((q) {
                              List image =
                                  q.where((p0) => p0.id == id).first.image ??
                                      [];
                              List file =
                                  q.where((p0) => p0.id == id).first.file ?? [];
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: image.isEmpty && file.isEmpty
                                            ? NetworkImage(url) as ImageProvider
                                            : image.isEmpty && file.isNotEmpty
                                                ? FileImage(file.first)
                                                : NetworkImage(image.isEmpty
                                                        ? url
                                                        : image.first)
                                                    as ImageProvider),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Icon(
                                    Icons.image_search,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }, QuestionController.instance.questions),
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
