import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/dashboard_complement_parallax_bloc.dart';
import 'widgets/complement_image.dart';

class DashboardComplementRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const DashboardComplementRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.w),
      child: Container(
        padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 247, 1),
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
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.lightBlueAccent[100]
                      ),
                      children: [
                        TextSpan(
                          text: "of all.",
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  ),
                  SizedBox(height: .1.sh),
                  RichText(
                    text: TextSpan(
                      text: "Nova Dashboard ",
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: "complements ",
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.lightBlueAccent[100]
                          ),
                        ),
                        TextSpan(
                          text: "your POS, not replaces it.",
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ]
                    )
                  ),
                  SizedBox(height: .1.sh),
                  Text(
                    "Use it when you want, or not at all.",
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ),
            BlocProvider<DashboardComplementParallaxBloc>(
              create: (_) => DashboardComplementParallaxBloc(),
              child: ComplementImage(businessListViewKey: _businessListViewKey)
            )
          ],
        ),
      ),
    );
  }
}