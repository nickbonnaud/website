import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/laptop_parallax_bloc.dart';

class LaptopImage extends StatelessWidget {
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const LaptopImage({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
      child: SizedBox(
        height: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
          ? .4.sh : ResponsiveWrapper.of(context).isSmallerThan(TABLET)
          ? .45.sh : .55.sh,
        width: ResponsiveWrapper.of(context).isSmallerThan(MOBILE) ? .95.sw : .7.sw,
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
                    ? _initialOffset(context: context).h
                    : state.parallaxOffset.h + _initialOffset(context: context).h,
                  child: FadeInImage.memoryNetwork(
                    key: BlocProvider.of<KeyHolderCubit>(context).state.dashboardLaptopImageKey,
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

  double _initialOffset({required BuildContext context}) {
    return ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
      ? 25 : ResponsiveWrapper.of(context).isSmallerThan(TABLET) 
      ? 50 : 75;
  }
  
  void _updateScroll({required BuildContext context, required ParallaxState parallaxState}) {
    BlocProvider.of<LaptopParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(parentKey: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey, childKey: BlocProvider.of<KeyHolderCubit>(context).state.dashboardLaptopImageKey);
    if (imageVisible != BlocProvider.of<LaptopParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<LaptopParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}