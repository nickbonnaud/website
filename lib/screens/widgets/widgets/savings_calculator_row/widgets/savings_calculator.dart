import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/resources/helpers/currency.dart';

import 'bloc/savings_calculator_bloc.dart';

class SavingsCalculator extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const SavingsCalculator({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController; 
  
  @override
  State<SavingsCalculator> createState() => _SavingsCalculatorState();
}
  
class _SavingsCalculatorState extends State<SavingsCalculator> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _counterGlobalKey = GlobalKey();

  late AnimationController _counterController;
  
  @override
  void initState() {
    super.initState();

    _counterController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    widget._scrollController.addListener(_updateCounterEnterView);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingsCalculatorBloc, SavingsCalculatorState>(
      builder: (context, state) {
        return Text(
          Currency.create(cents: (state.totalSavings * _counterController.value).round()),
          key: _counterGlobalKey,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        );
      }
    );
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  void _updateCounterEnterView() {
    if (_counterController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? iconObject = _counterGlobalKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || iconObject == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double iconObjectTop = iconObject.getTransformTo(businessListViewObject).getTranslation().y;

    final bool iconVisible = (iconObjectTop + _enterAnimationMinHeight) < listViewHeight;

    if (iconVisible) {
      _counterController.forward();
    }
  }
}