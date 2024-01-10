import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'text.dart';

Future<void> showBanner(String? title, error) async {
  showSimpleNotification(
    AppText(
      text: title ?? "",
      color: Colors.white,
    ),
    contentPadding: const EdgeInsets.all(10),
    slideDismiss: true,
    leading: Container(
      height: 32,
      width: 32,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Colors.transparent),
      child: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.notifications_active,
            color: Colors.white,
            size: 20,
          )),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AppText(
        text: error ?? "",
        color: Colors.white,
      ),
    ),
    elevation: 10,
    background: Colors.black.withOpacity(0.5),
    duration: const Duration(seconds: 5),
  );
}
