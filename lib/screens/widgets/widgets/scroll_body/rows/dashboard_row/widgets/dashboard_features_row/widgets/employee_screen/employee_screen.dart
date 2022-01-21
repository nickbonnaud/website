import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/resources/helpers/text_sizer.dart';

import 'widgets/employee_screen_image.dart';

class EmployeeScreen extends StatelessWidget {
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _businessListViewKey;

  EmployeeScreen({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.w),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(225, 250, 248, 1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: EmployeeScreenImage(businessListViewKey: _businessListViewKey),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Rich ",
                style: TextStyle(
                  fontSize: _textSizer.halfRow(context: context),
                  fontWeight: FontWeight.w800,
                  color: const Color.fromRGBO(21, 149, 136, 1)
                ),
                children: const [
                  TextSpan(
                    text: 'ecosystem of features',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  )
                ]
              )
            )
          )
        ],
      ),
    );
  }
}