import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

import '../bloc/employee_screen_parallax_bloc.dart';

class EmployeeScreenImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const EmployeeScreenImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<EmployeeScreenImage> createState() => _EmployeeScreenImageState();
}

class _EmployeeScreenImageState extends State<EmployeeScreenImage> {
  static final _initialOffset = 75.h;
  final GlobalKey _imageKey = GlobalKey();

  late EmployeeScreenParallaxBloc _parallaxBloc;
  late VisibilityFinder _visibilityFinder;

  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<EmployeeScreenParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: .7.sh,
        width: .2.sw,
        child: Stack(
          children: [
            BlocBuilder<EmployeeScreenParallaxBloc, EmployeeScreenParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .6.sh,
                  left: 0,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset
                    : _parallaxBloc.parallaxOffset + _initialOffset,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/dashboard/phone_2.png',
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

    bool imageVisible = _visibilityFinder.isVisible(initialOffset: 0);
    if (imageVisible != _parallaxBloc.state.isImageVisible) {
      _parallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}