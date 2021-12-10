import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

import '../bloc/dashboard_complement_parallax_bloc.dart';

class ComplementImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const ComplementImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<ComplementImage> createState() => _ComplementImageState();
}

class _ComplementImageState extends State<ComplementImage> {
  static final _initialOffset = 100.h;
  final GlobalKey _imageKey = GlobalKey();

  late DashboardComplementParallaxBloc _parallaxBloc;
  late VisibilityFinder _visibilityFinder;
  
  @override
  void initState() {
    _parallaxBloc = BlocProvider.of<DashboardComplementParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey);
    super.initState();
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
            BlocBuilder<DashboardComplementParallaxBloc, DashboardComplementParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: 1.5.sh,
                  left: 0,
                  top: state.entryPosition == null
                    ? _initialOffset
                    : _parallaxBloc.parallaxOffset + _initialOffset,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/dashboard/phone_1.png',
                    fit: BoxFit.fitHeight,
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

    bool imageVisible = _visibilityFinder.isVisible(initialOffset: _initialOffset);
    if (imageVisible != _parallaxBloc.state.isImageVisible) {
      _parallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}