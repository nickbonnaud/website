import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';

import 'bloc/receipt_image_parallax_bloc.dart';
import 'widgets/receipt_image.dart';

class ReceiptRow extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const ReceiptRow({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(top: 20.h, right: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 248, 239, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocProvider<ReceiptImageParallaxBloc>(
                create: (_) => ReceiptImageParallaxBloc(),
                child: const ReceiptImage(),
              )
            ),
            _separator(context: context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _separator({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return SizedBox(width: 20.w);
    }
    return Container();
  }
}