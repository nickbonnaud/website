import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/background_parallax_bloc.dart';
import 'widgets/background_image.dart';
import 'widgets/background_text/background_text.dart';
import 'widgets/background_text/bloc/background_text_bloc.dart';

class BackgroundParallax extends StatefulWidget {
  final ScrollController _scrollController;

  const BackgroundParallax({required ScrollController scrollController, Key? key})
    : _scrollController = scrollController,
      super(key: key);
  
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
            const BackgroundImage(),
            BlocProvider<BackgroundTextBloc>(
              create: (_) =>  BackgroundTextBloc(backgroundParallaxBloc: _backgroundParallaxBloc),
              child: const BackgroundText()
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