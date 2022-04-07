import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/image_parallax_bloc.dart';
import 'widgets/payment_image.dart';

class PaymentImageRow extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const PaymentImageRow({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "No tapping, swiping, or scanning.",
                    style: TextStyle(
                      fontSize: _textSize(context: context),
                      fontWeight: FontWeight.w800,
                      color: Colors.lightBlueAccent[100]
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Text(
                    "Customers pay with the Nova App.",
                    style: TextStyle(
                      fontSize: _textSize(context: context),
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              )
            ),
            BlocProvider<ImageParallaxBloc>(
              create: (_) => ImageParallaxBloc(),
              child: const PaymentImage(),
            )
          ],
        ),
      )
    );
  }

  double _textSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 55.sp;
    }
    return 50.sp;
  }
}