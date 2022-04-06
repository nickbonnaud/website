import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/integration_row_parallax_bloc.dart';

class IntegrationImage extends StatelessWidget {
  static const double _initialOffset = 175;
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const IntegrationImage({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
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
                    key: BlocProvider.of<KeyHolderCubit>(context).state.faqsIntegrationImageKey,
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

  void _updateScroll({required BuildContext context, required ParallaxState parallaxState}) {
    BlocProvider.of<IntegrationRowParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(parentKey: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey, childKey: BlocProvider.of<KeyHolderCubit>(context).state.faqsIntegrationImageKey);
    if (imageVisible != BlocProvider.of<IntegrationRowParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<IntegrationRowParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}