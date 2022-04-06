import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/sales_screen_parallax_bloc.dart';

class SalesScreenImage extends StatelessWidget {
  static const double _initialOffset = 125;
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const SalesScreenImage({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
      child: SizedBox(
        height: .6.sh,
        width: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
          ? .2.sw : .15.sw,
        child: Stack(
          children: [
            BlocBuilder<SalesScreenParallaxBloc, SalesScreenParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .5.sh,
                  left: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: BlocProvider.of<KeyHolderCubit>(context).state.dashboardSalesImageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/dashboard/tablet_1.png',
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

  void _updateScroll({required BuildContext context, required ParallaxState parallaxState}) {
    BlocProvider.of<SalesScreenParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(parentKey: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey, childKey: BlocProvider.of<KeyHolderCubit>(context).state.dashboardSalesImageKey);
    if (imageVisible != BlocProvider.of<SalesScreenParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<SalesScreenParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}