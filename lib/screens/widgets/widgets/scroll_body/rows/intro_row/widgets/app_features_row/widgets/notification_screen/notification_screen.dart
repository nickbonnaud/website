import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/helpers/text_sizer.dart';

import 'widgets/notification_screen_image.dart';

class NotificationScreen extends StatelessWidget {
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  NotificationScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(214, 228, 242, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Reduce wait ",
                    style: TextStyle(
                      fontSize: _textSizer.halfRow(context: context),
                      fontWeight: FontWeight.w800,
                    ),
                    children: const [
                      TextSpan(
                        text: "time",
                        style: TextStyle(
                          color: Color.fromRGBO(36, 79, 122, 1)
                        ),
                      )
                    ]
                  )
                ),
                SizedBox(height: 40.h),
                RichText(
                  text: TextSpan(
                    text: "Improve ",
                    style: TextStyle(
                      fontSize: _textSizer.halfRow(context: context),
                      fontWeight: FontWeight.w800,
                      color: const Color.fromRGBO(36, 79, 122, 1)
                    ),
                    children: const [
                      TextSpan(
                        text: "customer experience",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ]
                  )
                ),
              ],
            )
          ),
          _separator(context: context),
          Expanded(
            child: NotificationScreenImage(businessListViewKey: _businessListViewKey),
          )
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