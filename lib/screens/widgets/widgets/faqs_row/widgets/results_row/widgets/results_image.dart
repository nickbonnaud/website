import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

import '../bloc/results_row_parallax_bloc.dart';

class ResultsImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const ResultsImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<ResultsImage> createState() => _ResultsImageState();
}

class _ResultsImageState extends State<ResultsImage> {
  static const double _initialOffset = 200;
  final GlobalKey _imageKey = GlobalKey();

  late ResultsRowParallaxBloc _parallaxBloc;
  late VisibilityFinder _visibilityFinder;
  
  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<ResultsRowParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey);
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
            BlocBuilder<ResultsRowParallaxBloc, ResultsRowParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .4.sh,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : _parallaxBloc.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/dashboard/tablet_2.png',
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

    bool imageVisible = _visibilityFinder.isVisible(initialOffset: _initialOffset.h);
    if (imageVisible != _parallaxBloc.state.isImageVisible) {
      _parallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}