import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import 'widgets/background_parallax/background_parallax.dart';
import 'widgets/background_parallax/bloc/background_parallax_bloc.dart';
import 'widgets/scroll_body/scroll_body.dart';

class HomeScreenBody extends StatefulWidget {
  
  const HomeScreenBody({Key? key})
    : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController _scrollController = ScrollController();
  late ParallaxBloc _parallaxBloc;

  double get _screenHeight => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<ParallaxBloc>(context);
    _scrollController.addListener(_handleScrollNotification);
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundParallax(),
        _scrollableBody()
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _parallaxBloc.close();
    super.dispose();
  }

  Widget _backgroundParallax() {
    return BlocProvider<BackgroundParallaxBloc>(
      create: (_) => BackgroundParallaxBloc(
        initialImage: BackgroundParallaxBloc.firstImage,
        constantTopMargin: _screenHeight * .1,
        constantEntryDistanceFromTop: _screenHeight
      ),
      child: BackgroundParallax(scrollController: _scrollController),
    );
  }
  
  Widget _scrollableBody() {
    return ScrollBody(scrollController: _scrollController);
  }
  
  void _handleScrollNotification() {
    _parallaxBloc.add(ScrollUpdated(offset: _scrollController.offset));
  }
}