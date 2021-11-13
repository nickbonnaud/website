import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/faq_tab_bar_cubit.dart';


class FaqTabBar extends StatefulWidget {

  @override
  State<FaqTabBar> createState() => _FaqTabBarState();
}

class _FaqTabBarState extends State<FaqTabBar> with SingleTickerProviderStateMixin {
  late FaqTabBarCubit _faqTabBarCubit;
  
  @override
  void initState() {
    super.initState();
    _faqTabBarCubit = BlocProvider.of<FaqTabBarCubit>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return _tabBar();
  }

  @override
  void dispose() {
    _faqTabBarCubit.close();
    super.dispose();
  }

  Widget _tabBar() {
    return BlocBuilder<FaqTabBarCubit, int>(
      builder: (context, index) {
        return CupertinoTabBar(
          Colors.blue,
          Colors.lightBlue,
          [
            Text(
              "Integration",
              style: TextStyle(
                color: Colors.white,
                fontSize: index == 0 ? 32.sp : 28.sp
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Operation",
              style: TextStyle(
                color: Colors.white,
                fontSize: index == 1 ? 32.sp : 28.sp
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Results",
              style: TextStyle(
                color: Colors.white,
                fontSize: index == 2 ? 32.sp : 28.sp
              ),
              textAlign: TextAlign.center,
            )
          ],
          _faqTabBarCubit.currentIndex,
          (int index) => _faqTabBarCubit.indexChanged(index: index),
          allowExpand: true,
        );
      }
    );
  }
}