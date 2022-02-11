import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/image_parallax_bloc.dart';
import 'widgets/phone_image.dart';

class PaymentImageRow extends StatelessWidget {
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  PaymentImageRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;
  
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
                      fontSize: _textSizer.fullRowHeader(context: context),
                      fontWeight: FontWeight.w800,
                      color: Colors.lightBlueAccent[100]
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Text(
                    "Customers pay with the Nova App.",
                    style: TextStyle(
                      fontSize: _textSizer.fullRowHeader(context: context),
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              )
            ),
            BlocProvider<ImageParallaxBloc>(
              create: (_) => ImageParallaxBloc(),
              child: PhoneImage(businessListViewKey: _businessListViewKey),
            )
          ],
        ),
      )
    );
  }
}