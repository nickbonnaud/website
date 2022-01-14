import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/background_parallax_bloc.dart';
import 'widgets/background_image.dart';
import 'widgets/background_text/background_text.dart';
import 'widgets/background_text/bloc/background_text_bloc.dart';

class BackgroundParallax extends StatefulWidget {
  final ScrollController _scrollController;

  final GlobalKey _businessListViewKey;

  final GlobalKey _firstImageWindowKey;
  final GlobalKey _firstImageWindowBottomKey;

  final GlobalKey _secondImageWindowKey;
  final GlobalKey _secondImageWindowBottomKey;

  final GlobalKey _thirdImageWindowKey;
  final GlobalKey _thirdImageWindowBottomKey;

  final GlobalKey _fourthImageWindowKey;

  const BackgroundParallax({
    required ScrollController scrollController,
    required GlobalKey businessListViewKey,
    required GlobalKey firstImageWindowKey,
    required GlobalKey firstImageWindowBottomKey,
    required GlobalKey secondImageWindowKey,
    required GlobalKey secondImageWindowBottomKey,
    required GlobalKey thirdImageWindowKey,
    required GlobalKey thirdImageWindowBottomKey,
    required GlobalKey fourthImageWindowKey

  })
    : _scrollController = scrollController,
      _businessListViewKey = businessListViewKey,
      _firstImageWindowKey = firstImageWindowKey,
      _firstImageWindowBottomKey = firstImageWindowBottomKey,
      _secondImageWindowKey = secondImageWindowKey,
      _secondImageWindowBottomKey = secondImageWindowBottomKey,
      _thirdImageWindowKey = thirdImageWindowKey,
      _thirdImageWindowBottomKey = thirdImageWindowBottomKey,
      _fourthImageWindowKey = fourthImageWindowKey;
  
  @override
  State<BackgroundParallax> createState() => _BackgroundParallaxState();
}
  
class _BackgroundParallaxState extends State<BackgroundParallax> {
  late BackgroundParallaxBloc _backgroundParallaxBloc;
  
  @override
  void initState() {
    super.initState();
    _backgroundParallaxBloc = BlocProvider.of<BackgroundParallaxBloc>(context);
    widget._scrollController.addListener(_handleScrollNotification);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackgroundParallaxBloc, BackgroundParallaxState>(
      builder: (context, state) {
        return Stack(
          children: [
            BackgroundImage(
              businessListViewKey: widget._businessListViewKey,
              firstImageWindowKey: widget._firstImageWindowKey,
              firstImageWindowBottomKey: widget._firstImageWindowBottomKey,
              secondImageWindowKey: widget._secondImageWindowKey,
              secondImageWindowBottomKey: widget._secondImageWindowBottomKey,
              thirdImageWindowKey: widget._thirdImageWindowKey,
              thirdImageWindowBottomKey: widget._thirdImageWindowBottomKey,
              fourthImageWindowKey: widget._fourthImageWindowKey
            ),
            BlocProvider<BackgroundTextBloc>(
              create: (_) =>  BackgroundTextBloc(backgroundParallaxBloc: _backgroundParallaxBloc),
              child: BackgroundText(businessListViewKey: widget._businessListViewKey, secondImageWindowKey: widget._secondImageWindowKey)
            ) 
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    _backgroundParallaxBloc.close();
    super.dispose();
  }
  
  void _handleScrollNotification() {
    _backgroundParallaxBloc.add(ScrollChanged(absolutePositionY:  widget._scrollController.offset));
  }
}