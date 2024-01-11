import 'package:flutter/material.dart';
import 'package:verification/view/widget/text.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.edit_note_outlined,
          size: 40,
        ),
        SizedBox(
          height: 10,
        ),
        AppText(
          text: "Nothing found...",
          size: 16,
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
