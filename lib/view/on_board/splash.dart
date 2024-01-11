import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:verification/controller/operation/operation.dart';
import 'package:verification/view/home/home.dart';
import 'package:verification/view/widget/text.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: BounceInDown(
          duration: const Duration(seconds: 5),
          animate: true,
          child: Center(
            child: AppText(
              text: "Verification",
              size: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Operations.callData(context);
    });
  }
}
