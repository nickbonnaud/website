import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/typical_savings_title_cubit.dart';

class TypicalSavingsTitle extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;
  final GlobalKey _secondImageWindowKey;


  const TypicalSavingsTitle({
    required GlobalKey businessListViewKey,
    required ScrollController scrollController,
    required GlobalKey secondImageWindowKey
  })
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController,
      _secondImageWindowKey = secondImageWindowKey;

  @override
  State<TypicalSavingsTitle> createState() => _TypicalSavingsTitleState();
}

class _TypicalSavingsTitleState extends State<TypicalSavingsTitle> {
  static const double _enterAnimationMinHeight = 500;

  late TypicalSavingsTitleCubit _titleCubit;

  @override
  void initState() {
    super.initState();
    _titleCubit = BlocProvider.of<TypicalSavingsTitleCubit>(context);
    widget._scrollController.addListener(_didEnterView);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypicalSavingsTitleCubit, double>(
      builder: (context, opacity) {
        return Text(
          "Typical Savings",
          style: TextStyle(
            fontSize: 60.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(opacity)
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    _titleCubit.close();
    super.dispose();
  }

  void _didEnterView() {
    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? savingsTitle = widget._secondImageWindowKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || savingsTitle == null) return;
    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double savingsTitleTop = savingsTitle.getTransformTo(businessListViewObject).getTranslation().y;

    final bool savingsTitleVisible = (savingsTitleTop + _enterAnimationMinHeight) < listViewHeight;
    
    if (savingsTitleVisible) {
      final double position = (listViewHeight - (savingsTitleTop + _enterAnimationMinHeight));
      _titleCubit.scroll(position: position);
    }
  }
}