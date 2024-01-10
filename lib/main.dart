import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/view/home/home.dart';
import 'package:verification/view/on_board/splash.dart';

import 'controller/backoffice/db.dart';
import 'controller/operation/network_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CheckConnect.networkCheck(false);
  await Database.initDatabase();
  Operations.initControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'Verification',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
