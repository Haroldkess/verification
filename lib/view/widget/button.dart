import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verification/controller/network_calls/report_controller.dart';
import 'package:verification/view/widget/text.dart';

class AppButton extends StatelessWidget {
  final String text;

  VoidCallback onTap;

  AppButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black,
            fixedSize: Size(_width * 0.95, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            side: BorderSide(
                color: Colors.black, width: 1.0, style: BorderStyle.solid)),
        onPressed: onTap,
        child: AppText(
          text: text,
          scaleFactor: 0.8,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ));
  }
}

class AppDropDown extends StatelessWidget {
  Function(dynamic val)? onChange;
  AppDropDown({super.key, this.onChange});

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'pre-visit';
    var items = [
      'pre-visit',
      'on-visit',
      'post-visit',
      'verifier-Visit',
      'lab-Test'
    ];

    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              child: AppText(
                text: "Collection stage",
                fontWeight: FontWeight.bold,
                size: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(.4)),
          child: Center(
            child: GetBuilder(
                init: ReportController(),
                builder: (select) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButtonFormField(
                        // Initial Value
                        value: select.type.value,
                        alignment: Alignment.centerLeft,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),

                        // Down Arrow Icon
                        //  icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (val) {
                          select.addType(val);
                        }),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class AppDropDownReport extends StatelessWidget {
  Function(dynamic val)? onChange;
  bool? isQuestion;
  AppDropDownReport({super.key, this.onChange, this.isQuestion});

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'field';
    var items = [
      'field',
      'farm',
    ];

    return Column(
      children: [
        isQuestion == true
            ? SizedBox.shrink()
            : Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: Get.width * 0.8),
                    child: AppText(
                      text: "Question level",
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                  ),
                ],
              ),
        isQuestion == true
            ? SizedBox.shrink()
            : const SizedBox(
                height: 2,
              ),
        isQuestion == true
            ? Center(
                child: GetBuilder(
                    init: ReportController(),
                    builder: (select) {
                      return DropdownButton(
                          // Initial Value
                          value: select.level.value,
                          alignment: Alignment.topCenter,

                          // Down Arrow Icon
                          //  icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (val) {
                            select.addLevel(val);
                          });
                    }),
              )
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isQuestion == true
                        ? null
                        : Colors.grey.withOpacity(.4)),
                child: Center(
                  child: GetBuilder(
                      init: ReportController(),
                      builder: (select) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButtonFormField(
                              // Initial Value
                              value: select.level.value,
                              alignment: Alignment.centerLeft,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),

                              // Down Arrow Icon
                              //  icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (val) {
                                select.addLevel(val);
                              }),
                        );
                      }),
                ),
              ),
      ],
    );
  }
}
