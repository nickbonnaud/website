import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/notification_screen_parallax_bloc.dart';

class NotificationScreenImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const NotificationScreenImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<NotificationScreenImage> createState() => _NotificationScreenImageState();
}

class _NotificationScreenImageState extends State<NotificationScreenImage> {
  static const double _initialOffset = 120;
  final GlobalKey _imageKey = GlobalKey();

  late VisibilityFinder _visibilityFinder;
  
  @override
  void initState() {
    super.initState();
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey, enterAnimationMinHeight: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: .6.sh,
        width: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
          ? .2.sw : .15.sw,
        child: Stack(
          children: [
            BlocBuilder<NotificationScreenParallaxBloc, NotificationScreenParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .5.sh,
                  left: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_3.png',
                    fit: BoxFit.contain,
                  )
                );
              }
            )
          ],
        ),
      ),
    );
  }

  void _updateScroll({required ParallaxState parallaxState}) {
    BlocProvider.of<NotificationScreenParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible();
    if (imageVisible != BlocProvider.of<NotificationScreenParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<NotificationScreenParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}