import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

import '../bloc/laptop_parallax_bloc.dart';

class LaptopImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const LaptopImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<LaptopImage> createState() => _LaptopImageState();
}

class _LaptopImageState extends State<LaptopImage> {
  final GlobalKey _imageKey = GlobalKey();

  late LaptopParallaxBloc _laptopParallaxBloc;
  late VisibilityFinder _visibilityFinder;
  late double _initialOffset;
  
  @override
  void initState() {
    super.initState();
    _laptopParallaxBloc = BlocProvider.of<LaptopParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey);
  }
  
  @override
  Widget build(BuildContext context) {
    _initialOffset = ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
      ? 0 : ResponsiveWrapper.of(context).isSmallerThan(TABLET) 
      ? 25 : 50;

    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
          ? .4.sh : ResponsiveWrapper.of(context).isSmallerThan(TABLET)
          ? .45.sh : .55.sh,
        width: .7.sw,
        child: Stack(
          children: [
            BlocBuilder<LaptopParallaxBloc, LaptopParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .55.sh,
                  left: 0,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : _laptopParallaxBloc.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/dashboard/laptop.png',
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

  @override
  void dispose() {
    _laptopParallaxBloc.close();
    super.dispose();
  }
  
  void _updateScroll({required ParallaxState parallaxState}) {
    _laptopParallaxBloc.add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(initialOffset: _initialOffset.h);
    if (imageVisible != _laptopParallaxBloc.state.isImageVisible) {
      _laptopParallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}