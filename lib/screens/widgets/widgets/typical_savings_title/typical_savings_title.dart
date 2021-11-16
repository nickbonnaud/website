import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

import 'cubit/typical_savings_title_cubit.dart';

class TypicalSavingsTitle extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final GlobalKey _secondImageWindowKey;


  const TypicalSavingsTitle({
    required GlobalKey businessListViewKey,
    required GlobalKey secondImageWindowKey
  })
    : _businessListViewKey = businessListViewKey,
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
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _didEnterView();
      },
      child: BlocBuilder<TypicalSavingsTitleCubit, double>(
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
      ),
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