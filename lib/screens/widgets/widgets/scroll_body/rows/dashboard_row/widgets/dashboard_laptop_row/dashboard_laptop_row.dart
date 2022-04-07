import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/laptop_parallax_bloc.dart';
import 'widgets/laptop_image.dart';

class DashboardLaptopRow extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const DashboardLaptopRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(60.w, 40.h, 60.w, 0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 244, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Dashboard effortlessly ",
                style: TextStyle(
                  fontSize: _textSize(context: context),
                  fontWeight: FontWeight.w800,
                ),
                children: const [
                  TextSpan(
                    text: "syncs ",
                    style: TextStyle(
                      color: Color.fromRGBO(230, 37, 101, 1)
                    )
                  ),
                  TextSpan(
                    text: "with your POS.",
                  )
                ]
              )
            ),
            BlocProvider<LaptopParallaxBloc>(
              create: (_) => LaptopParallaxBloc(),
              child: const LaptopImage()
            ),
          ],
        ),
      ),
    );
  }

  double _textSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 55.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 45.sp;
    }
    return 50.sp;
  }
}