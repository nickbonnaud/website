import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/integration_row_parallax_bloc.dart';

class IntegrationImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const IntegrationImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<IntegrationImage> createState() => _IntegrationImageState();
}

class _IntegrationImageState extends State<IntegrationImage> {
  static const double _initialOffset = 175;
  final GlobalKey _imageKey = GlobalKey();

  late IntegrationRowParallaxBloc _parallaxBloc;
  late VisibilityFinder _visibilityFinder;

  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<IntegrationRowParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey, enterAnimationMinHeight: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: .7.sh,
        width: ResponsiveWrapper.of(context).isSmallerThan(MOBILE) 
          ? .55.sw : ResponsiveWrapper.of(context).isSmallerThan(TABLET) 
          ? .4.sw : .3.sw,
        child: Stack(
          children: [
            BlocBuilder<IntegrationRowParallaxBloc, IntegrationRowParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .4.sh,
                  left: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
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
    _parallaxBloc.close();
    super.dispose();
  }

  void _updateScroll({required ParallaxState parallaxState}) {
    _parallaxBloc.add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible();
    if (imageVisible != _parallaxBloc.state.isImageVisible) {
      _parallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}