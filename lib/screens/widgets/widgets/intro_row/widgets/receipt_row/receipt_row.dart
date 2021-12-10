import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/receipt_image_parallax_bloc.dart';
import 'widgets/receipt_image.dart';

class ReceiptRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const ReceiptRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 248, 239, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocProvider<ReceiptImageParallaxBloc>(
              create: (_) => ReceiptImageParallaxBloc(),
              child: ReceiptImage(businessListViewKey: _businessListViewKey),
            ),
            Expanded(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Receipts updated in ",
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: 'real-time',
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(226, 98, 84, 1)
                          )
                        )
                      ]
                    )
                  ),
                  SizedBox(height: .2.sh),
                  RichText(
                    text: TextSpan(
                      text: "Customer can view their live bill, ",
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: 'saving ',
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(226, 98, 84, 1)
                          )
                        ),
                        TextSpan(
                          text: 'costly or time consuming mistakes.',
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w800,
                          )
                        )
                      ]
                    )
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}