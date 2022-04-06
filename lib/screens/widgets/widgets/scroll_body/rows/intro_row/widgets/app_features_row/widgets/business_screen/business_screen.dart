import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';

import 'widgets/business_screen_image.dart';

class BusinessScreen extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const BusinessScreen({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(236, 229, 242, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: BusinessScreenImage(),
          ),
          _separator(context: context),
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: "Reach ",
                    style: TextStyle(
                      fontSize: _textSizer.halfRow(context: context),
                      fontWeight: FontWeight.w800,
                    ),
                    children: const [
                      TextSpan(
                        text: "new ",
                        style: TextStyle(
                          color: Color.fromRGBO(121, 96, 241, 1)
                        )
                      ),
                      TextSpan(
                        text: "customers",
                        style: TextStyle(
                        ),
                      )
                    ]
                  ),
                ),
                SizedBox(height: 40.h),
                RichText(
                  text: TextSpan(
                    text: "Expand ",
                    style: TextStyle(
                      fontSize: _textSizer.halfRow(context: context),
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(121, 96, 241, 1)
                    ),
                    children: const [
                      TextSpan(
                        text: "your ",
                        style: TextStyle(
                          color: Colors.black
                        )
                      ),
                      TextSpan(
                        text: "business",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ]
                  ),
                )
              ],
            )
          ),
        ],
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