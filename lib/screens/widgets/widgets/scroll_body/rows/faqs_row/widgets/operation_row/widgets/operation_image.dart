import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/operation_row_parallax_bloc.dart';

class OperationImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const OperationImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<OperationImage> createState() => _OperationImageState();
}

class _OperationImageState extends State<OperationImage> {
  final GlobalKey _imageKey = GlobalKey();

  late OperationRowParallaxBloc _parallaxBloc;
  late VisibilityFinder _visibilityFinder;
  late double _initialOffset;
  
  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<OperationRowParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey, enterAnimationMinHeight: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    _initialOffset = ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
      ? 50 : 100;

    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: .3.sh,
        width: _imageWidth(),
        child: Stack(
          children: [
            BlocBuilder<OperationRowParallaxBloc, OperationRowParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .4.sh,
                  left: 0,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_5.png',
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

  double _imageWidth() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .8.sw;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .7.sw;
    }
    return .6.sw;
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