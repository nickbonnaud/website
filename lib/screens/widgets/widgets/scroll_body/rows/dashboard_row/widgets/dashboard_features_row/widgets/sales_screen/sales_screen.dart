import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/text_sizer.dart';

import 'widgets/sales_screen_image.dart';

class SalesScreen extends StatelessWidget {
  final TextSizer _textSizer = const TextSizer();

  const SalesScreen({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(254, 248, 234, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Intuitive sales ",
                style: TextStyle(
                  fontSize: _textSizer.halfRow(context: context),
                  fontWeight: FontWeight.w800,
                ),
                children: const [
                  TextSpan(
                    text: "tracking",
                    style: TextStyle(
                      color: Color.fromRGBO(253, 192, 47, 1)
                    )
                  ),
                ]
              ),
            )
          ),
          const Expanded(
            child: SalesScreenImage(),
          )
        ],
      ),
    );
  }
}