import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

import '../bloc/image_parallax_bloc.dart';

class PhoneImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const PhoneImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<PhoneImage> createState() => _PhoneImageState();
}

class _PhoneImageState extends State<PhoneImage> {
  static final _initialOffset = 100.h;
  final GlobalKey _imageKey = GlobalKey();

  late ImageParallaxBloc _imageParallaxBloc;
  late VisibilityFinder _visibilityFinder;

  @override
  void initState() {
    super.initState();
    _imageParallaxBloc = BlocProvider.of<ImageParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: .8.sh,
        width: .4.sw,
        child: Stack(
          children: [
            BlocBuilder<ImageParallaxBloc, ImageParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .6.sh,
                  left: 0,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset
                    : _imageParallaxBloc.parallaxOffset + _initialOffset,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_2.png',
                    fit: BoxFit.fitHeight,
                  )
                );
              }
            ),
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    _imageParallaxBloc.close();
    super.dispose();
  }

  void _updateScroll({required ParallaxState parallaxState}) {
    _imageParallaxBloc.add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(initialOffset: _initialOffset);
    if (imageVisible != _imageParallaxBloc.state.isImageVisible) {
      _imageParallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}