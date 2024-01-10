import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verification/controller/network_calls/question_call.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/view/widget/text.dart';
import 'package:intl/intl.dart';
import '../../controller/backoffice/api_url.dart';

class QuestionForm extends StatefulWidget {
  Color? backColor;
  bool? enable;
  TextEditingController? controller;
  TextInputType? textInputType;
  int? id;
  bool? isDate;
  String? question;

  final GlobalKey<FormFieldState>? formFieldKey;
  QuestionForm(
      {super.key,
      this.backColor,
      this.controller,
      this.question,
      this.id,
      this.textInputType,
      this.enable,
      this.isDate,
      this.formFieldKey});

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  bool validated = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              child: AppText(
                text: widget.question ?? "",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        ObxValue((q) {
          List check = q.where((p0) => p0.id == widget.id).first.answer ?? [];
          // consoleLog(check.toString());
          return Center(
            child: widget.isDate == true
                ? dayMonthYear(
                    context, check.isEmpty ? "dd/mm/yyy" : check.first)
                : TextFormField(
                    key: widget.formFieldKey == null
                        ? null
                        : widget.formFieldKey!,
                    keyboardType: widget.textInputType,
                    enabled: widget.enable ?? true,
                    initialValue: check.isEmpty ? "" : check.first,
                    onChanged: (val) {
                      QuestionController.instance.addAnswer(val, widget.id!);
                    },
                    style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.3),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none),
                    )),
          );
        }, QuestionController.instance.questions),
      ],
    );
  }

  InkWell dayMonthYear(
    BuildContext context,
    String data,
  ) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2005),
            firstDate: DateTime(1970),
            lastDate: DateTime.now());

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          consoleLog(formattedDate);
          QuestionController.instance.addAnswer(formattedDate, widget.id!);
        } else {
          consoleLog("Date is not selected");
        }
      },
      child: TextFormField(
        enabled: false,
        cursorColor: Colors.black,
        style: GoogleFonts.leagueSpartan(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(.3),
          suffixIcon: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.date_range_outlined,
                color: Colors.black,
              )
            ],
          ),
          contentPadding: const EdgeInsets.only(left: 20, top: 17),
          hintText: data,
          hintStyle: GoogleFonts.leagueSpartan(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class AppForm extends StatelessWidget {
  final String? title;
  TextEditingController? controller;
  bool? isField;
  AppForm({super.key, this.title, this.controller, this.isField});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              child: AppText(
                text: title ?? "",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Center(
          child: TextFormField(
              controller: controller,
              onChanged: (val) {
                isField == true
                    ? ReportController.instance.addFieldName(val)
                    : ReportController.instance.addFarmName(val);
              },
              style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(.3),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none),
              )),
        )
      ],
    );
  }
}
