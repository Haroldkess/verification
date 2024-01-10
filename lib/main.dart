import 'dart:io';

import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:advance_image_picker/configs/image_picker_configs.dart';
import 'package:advance_image_picker/widgets/editors/image_sticker.dart';
import 'package:cloudflare/cloudflare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/view/home/home.dart';
import 'package:verification/view/on_board/splash.dart';
import 'package:intl/intl.dart';
import 'controller/backoffice/db.dart';
import 'controller/operation/network_controller.dart';

const String apiUrl = String.fromEnvironment('CLOUDFLARE_API_URL',
    defaultValue: 'https://api.cloudflare.com/client/v4');
const String accountId = String.fromEnvironment('CLOUDFLARE_ACCOUNT_ID',
    defaultValue: 'f3cf0f0442de28182c41a584b8e5cd7c');
const String token = String.fromEnvironment('CLOUDFLARE_TOKEN',
    defaultValue: 'YhGxUEPSGO_9O_k9xf3F6ImE-9c8PI-qkwKcrcgA');
const String apiKey =
    String.fromEnvironment('CLOUDFLARE_API_KEY', defaultValue: '');
const String accountEmail = String.fromEnvironment('CLOUDFLARE_ACCOUNT_EMAIL',
    defaultValue: 'haroldkess77@GMAIL.COM');
const String userServiceKey =
    String.fromEnvironment('CLOUDFLARE_USER_SERVICE_KEY', defaultValue: '');

String? cloudflareInitMessage;

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final configs = ImagePickerConfigs();
    // AppBar text color
    configs.appBarTextColor = Colors.black;
    configs.appBarBackgroundColor = Colors.white;
    // Disable select images from album
    // configs.albumPickerModeEnabled = false;
    // Only use front camera for capturing
    // configs.cameraLensDirection = 0;
    // Translate function
    configs.cropFeatureEnabled = true;
    configs.stickerFeatureEnabled = false;
    configs.cameraPickerModeEnabled = Platform.isIOS ? false : true;
    configs.imagePreProcessingEnabled = true;
    configs.albumPickerModeEnabled = true;
    configs.filterFeatureEnabled = true;
    configs.translateFunc = (name, value) => Intl.message(value, name: name);
    // Disable edit function, then add other edit control instead
    configs.adjustFeatureEnabled = true;
    configs.externalImageEditors['external_image_editor_1'] = EditorParams(
        title: 'Edit Image',
        icon: Icons.edit_rounded,
        onEditorEvent: (
                {required BuildContext context,
                required File file,
                required String title,
                int maxWidth = 1080,
                int maxHeight = 1920,
                int compressQuality = 90,
                ImagePickerConfigs? configs}) async =>
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ImageEdit(
                    file: file,
                    title: title,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    configs: configs))));

    configs.externalImageEditors['external_image_editor_2'] = EditorParams(
        title: 'Edit Image',
        icon: Icons.edit_attributes,
        onEditorEvent: (
                {required BuildContext context,
                required File file,
                required String title,
                int maxWidth = 1080,
                int maxHeight = 1920,
                int compressQuality = 90,
                ImagePickerConfigs? configs}) async =>
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ImageSticker(
                    file: file,
                    title: title,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    configs: configs))));
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
