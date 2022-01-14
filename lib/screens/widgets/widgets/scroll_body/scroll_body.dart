import 'package:flutter/material.dart';

import 'rows/dashboard_row/dashboard_row.dart';
import 'rows/faqs_row/faqs_row.dart';
import 'rows/intro_row/intro_row.dart';
import 'rows/savings_row/savings_row.dart';
import 'widgets/main_app_bar/main_app_bar.dart';
import 'widgets/welcome_title/welcome_title.dart';

class ScrollBody extends StatelessWidget {
  final ScrollController _scrollController;

  final GlobalKey _businessListViewKey;

  final GlobalKey _firstImageWindowKey;
  final GlobalKey _firstImageWindowBottomKey;

  final GlobalKey _secondImageWindowKey;
  final GlobalKey _secondImageWindowBottomKey;

  final GlobalKey _thirdImageWindowKey;
  final GlobalKey _thirdImageWindowBottomKey;

  final GlobalKey _fourthImageWindowKey;

  final GlobalKey _aboutKey;
  final GlobalKey _pricingKey;
  final GlobalKey _integrationKey;
  final GlobalKey _faqsKey;
  
  const ScrollBody({
    required ScrollController scrollController,
    required GlobalKey businessListViewKey,
    required GlobalKey firstImageWindowKey,
    required GlobalKey firstImageWindowBottomKey,
    required GlobalKey secondImageWindowKey,
    required GlobalKey secondImageWindowBottomKey,
    required GlobalKey thirdImageWindowKey,
    required GlobalKey thirdImageWindowBottomKey,
    required GlobalKey fourthImageWindowKey,
    required GlobalKey aboutKey,
    required GlobalKey pricingKey,
    required GlobalKey integrationKey,
    required GlobalKey faqsKey
  })
    : _scrollController = scrollController,
      _businessListViewKey = businessListViewKey,
      _firstImageWindowKey = firstImageWindowKey,
      _firstImageWindowBottomKey = firstImageWindowBottomKey,
      _secondImageWindowKey = secondImageWindowKey,
      _secondImageWindowBottomKey = secondImageWindowBottomKey,
      _thirdImageWindowKey = thirdImageWindowKey,
      _thirdImageWindowBottomKey = thirdImageWindowBottomKey,
      _fourthImageWindowKey = fourthImageWindowKey,
      _aboutKey = aboutKey,
      _pricingKey = pricingKey,
      _integrationKey = integrationKey,
      _faqsKey = faqsKey;
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: _businessListViewKey,
      shrinkWrap: true,
      controller: _scrollController,
      slivers: [
        _appBar(),
        SliverToBoxAdapter(
          key: _firstImageWindowKey,
          child: SizedBox(
            height: _screenHeight(context: context),
            child: WelcomeTitle(),
          ),
        ),
        SliverToBoxAdapter(
          key: _firstImageWindowBottomKey,
          child: Container(),
        ),
        SliverToBoxAdapter(
          key: _aboutKey,
          child: IntroRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _secondImageWindowKey,
          child: SizedBox(height: _screenHeight(context: context)),
        ),
        SliverToBoxAdapter(
          key: _secondImageWindowBottomKey,
          child: Container(),
        ),
        SliverToBoxAdapter(
          key: _pricingKey,
          child: SavingsRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _thirdImageWindowKey,
          child: SizedBox(height: _screenHeight(context: context)),
        ),
        SliverToBoxAdapter(
          key: _thirdImageWindowBottomKey,
          child: Container(),
        ),
        SliverToBoxAdapter(
          key: _integrationKey,
          child: DashboardRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _fourthImageWindowKey,
          child: SizedBox(height: _screenHeight(context: context)),
        ),
        SliverToBoxAdapter(
          key: _faqsKey,
          child: FaqsRow(businessListViewKey: _businessListViewKey)
        ),
      ],
    );
  }

  double _screenHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  Widget _appBar() {
    return MainAppBar(
      scrollController: _scrollController,
      businessListViewKey: _businessListViewKey,
      aboutKey: _aboutKey,
      pricingKey: _pricingKey,
      integrationKey: _integrationKey,
      faqsKey: _faqsKey
    );
  }
}