import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/screens/widgets/widgets/business_data_row/business_data_row.dart';

import '../cubit/home_screen_cubit.dart';
import 'widgets/savings_calculator_row/savings_calculator_row.dart';

class HomeScreenBody extends StatefulWidget {

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController _controller = ScrollController();
  final GlobalKey _businessListViewKey = GlobalKey();

  double get _screenWidth => MediaQuery.of(context).size.width;
  double get _screenHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: BlocBuilder<HomeScreenCubit, double>(
        builder: (context, offset) {
          return Stack(
            children: [
              Positioned(
                top: -.25 * offset,
                child: Image.asset(
                  'landscape/bar_landscape.jpg',
                  fit: BoxFit.fitWidth,
                  width: _screenWidth,
                  height: _screenHeight,
                )
              ),
              Positioned(
                top: (_screenHeight * .8) - offset,
                left: 0,
                right: 0,
                height: _screenHeight * .2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 1],
                      colors: [Colors.indigo.withOpacity(0), Colors.indigo]
                    )
                  ),
                  child: const SizedBox(width: double.infinity),
                )
              ),
              ListView(
                key: _businessListViewKey,
                cacheExtent: 100,
                addAutomaticKeepAlives: false,
                controller: _controller,
                children: [
                  SizedBox(height: _screenHeight),
                  BusinessDataRow(businessListViewKey: _businessListViewKey, scrollController: _controller),
                  const SizedBox(
                    height: 40.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                  SavingsCalculatorRow(businessListViewKey: _businessListViewKey, scrollController: _controller)
                ],
              )
            ],
          );
        }
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      context.read<HomeScreenCubit>().scrollUpdated(offset: notification.metrics.pixels);
    }
    return false;
  }
}