import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/faq_row_body.dart';
import 'widgets/widgets/faq_tab_bar/cubit/faq_tab_bar_cubit.dart';

class FaqsRow extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.7),
          spreadRadius: 15,
          blurRadius: 5,
          offset: const Offset(0, 3))
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 20),
        child: BlocProvider<FaqTabBarCubit>(
          create: (_) => FaqTabBarCubit(),
          child: FaqRowBody()
        )
      )
    );
  }
}