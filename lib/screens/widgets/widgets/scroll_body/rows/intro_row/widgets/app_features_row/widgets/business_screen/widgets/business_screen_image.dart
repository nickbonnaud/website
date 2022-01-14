import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/business_screen_parallax_bloc.dart';

class BusinessScreenImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const BusinessScreenImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey; 

  @override
  State<BusinessScreenImage> createState() => _BusinessScreenImageState();
}

class _BusinessScreenImageState extends State<BusinessScreenImage> {
  static const double _initialOffset = 75;
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
            BlocBuilder<BusinessScreenParallaxBloc, BusinessScreenParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .5.sh,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_1.png',
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
    BlocProvider.of<BusinessScreenParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible();
    if (imageVisible != BlocProvider.of<BusinessScreenParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<BusinessScreenParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}