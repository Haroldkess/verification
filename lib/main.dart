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
    configs.appBarTextColor = Colors.black;
    configs.appBarBackgroundColor = Colors.white;
    configs.cropFeatureEnabled = true;
    configs.stickerFeatureEnabled = false;
    configs.cameraPickerModeEnabled = Platform.isIOS ? false : true;
    configs.imagePreProcessingEnabled = true;
    configs.albumPickerModeEnabled = true;
    configs.filterFeatureEnabled = true;
    configs.translateFunc = (name, value) => Intl.message(value, name: name);
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
        title: 'Regenified-verifier-tool',
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
