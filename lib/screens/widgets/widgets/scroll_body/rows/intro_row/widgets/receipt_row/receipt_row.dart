import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/text_sizer.dart';

import 'bloc/receipt_image_parallax_bloc.dart';
import 'widgets/receipt_image.dart';

class ReceiptRow extends StatelessWidget {
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  ReceiptRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 248, 239, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: BlocProvider<ReceiptImageParallaxBloc>(
                create: (_) => ReceiptImageParallaxBloc(),
                child: ReceiptImage(businessListViewKey: _businessListViewKey),
              )
            ),
            Expanded(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Receipts updated in ",
                      style: TextStyle(
                        fontSize: _textSizer.fullRowHeader(context: context),
                        fontWeight: FontWeight.w800,
                      ),
                      children: const [
                        TextSpan(
                          text: 'real time',
                          style: TextStyle(
                            color: Color.fromRGBO(226, 98, 84, 1)
                          )
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 60.h),
                  RichText(
                    text: TextSpan(
                      text: "Customer can view their live bill, ",
                      style: TextStyle(
                        fontSize: _textSizer.fullRowBody(context: context),
                        fontWeight: FontWeight.w800,
                      ),
                      children: const [
                        TextSpan(
                          text: 'saving ',
                          style: TextStyle(
                            color: Color.fromRGBO(226, 98, 84, 1)
                          )
                        ),
                        TextSpan(
                          text: 'costly or time consuming mistakes',
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