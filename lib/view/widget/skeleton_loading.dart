import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:verification/view/widget/text.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return SkelView();
        });
  }
}

class SkelView extends StatelessWidget {
  const SkelView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(.4),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child: Container(
                      width: 150,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(.4),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child: Container(
                      width: 80,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.white.withOpacity(.4),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child: Container(
                      width: 70,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          //    color: Colors.amber,
        ),
        Divider()
      ],
    );
  }
}
