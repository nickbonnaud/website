import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/dashboard_complement_parallax_bloc.dart';
import 'widgets/complement_image.dart';

class DashboardComplementRow extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const DashboardComplementRow({Key? key})
    :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(left: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(241, 238, 254, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Best ",
                      style: TextStyle(
                        fontSize: _header(context: context),
                        fontWeight: FontWeight.w800,
                        color: const Color.fromRGBO(121, 96, 241, 1)
                      ),
                      children: const [
                        TextSpan(
                          text: "of all.",
                          style: TextStyle(
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 60.h),
                  RichText(
                    text: TextSpan(
                      text: "Nova Dashboard ",
                      style: TextStyle(
                        fontSize: _subHeader(context: context),
                        fontWeight: FontWeight.w800,
                      ),
                      children: const [
                        TextSpan(
                          text: "complements ",
                          style: TextStyle(
                            color: Color.fromRGBO(121, 96, 241, 1)
                          ),
                        ),
                        TextSpan(
                          text: "your POS, not replaces it.",
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 60.h),
                  Text(
                    "Use it when you want, or not at all.",
                    style: TextStyle(
                      fontSize: _textSizer.fullRowBody(context: context,largeMobileText: true),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ),
            BlocProvider<DashboardComplementParallaxBloc>(
              create: (_) => DashboardComplementParallaxBloc(),
              child: const ComplementImage()
            )
          ],
        ),
      ),
    );
  }

  double _header({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 60.sp;
    }
    return 50.sp;
  }

  double _subHeader({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 65.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 50.sp;
    }
    return 45.sp;
  }
}