import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';

import 'rows/dashboard_row/dashboard_row.dart';
import 'rows/faqs_row/faqs_row.dart';
import 'rows/intro_row/intro_row.dart';
import 'rows/savings_row/savings_row.dart';
import 'widgets/main_app_bar/main_app_bar.dart';
import 'widgets/welcome_title/welcome_title.dart';

class ScrollBody extends StatelessWidget {
  final ScrollController _scrollController;
  
  const ScrollBody({required ScrollController scrollController, Key? key})
    : _scrollController = scrollController,
      super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey,
      shrinkWrap: true,
      controller: _scrollController,
      slivers: [
        _appBar(),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.firstImageWindowKey,
          child: SizedBox(
            height: _screenHeight(context: context),
            child: const WelcomeTitle(),
          ),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.firstImageWindowBottomKey,
          child: Container(),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.aboutKey,
          child: const IntroRow(),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.secondImageWindowKey,
          child: SizedBox(height: _screenHeight(context: context)),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.secondImageWindowBottomKey,
          child: Container(),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.pricingKey,
          child: const SavingsRow(),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.thirdImageWindowKey,
          child: SizedBox(height: _screenHeight(context: context)),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.thirdImageWindowBottomKey,
          child: Container(),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.integrationKey,
          child: const DashboardRow(),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.fourthImageWindowKey,
          child: SizedBox(height: _screenHeight(context: context)),
        ),
        SliverToBoxAdapter(
          key: BlocProvider.of<KeyHolderCubit>(context).state.faqsKey,
          child: const FaqsRow()
        ),
      ],
    );
  }

  double _screenHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  Widget _appBar() {
    return MainAppBar(scrollController: _scrollController);
  }
}