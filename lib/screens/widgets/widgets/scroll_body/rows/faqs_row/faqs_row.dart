import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/integration_row/integration_row.dart';
import 'widgets/operation_row/operation_row.dart';
import 'widgets/ready_button/cubit/ready_button_cubit.dart';
import 'widgets/ready_button/ready_button.dart';
import 'widgets/results_row/results_row.dart';

class FaqsRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const FaqsRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

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
      child: Column(
        children: [
          SizedBox(height: 30.h),
          IntegrationRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          OperationRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          ResultsRow(businessListViewKey: _businessListViewKey),
          SizedBox(height: 60.h),
          BlocProvider<ReadyButtonCubit>(
            create: (_) => ReadyButtonCubit(),
            child: ReadyButton(),
          ),
          SizedBox(height: 60.h),
        ],
      )
    );
  }
}