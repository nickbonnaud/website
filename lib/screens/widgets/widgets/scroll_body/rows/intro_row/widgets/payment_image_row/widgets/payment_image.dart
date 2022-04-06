import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/image_parallax_bloc.dart';

class PaymentImage extends StatelessWidget {
  static const double _initialOffset = 100;
  final  VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const PaymentImage({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
      child: SizedBox(
        height: .7.sh,
        width: ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
          ? .4.sw : .25.sw,
        child: Stack(
          children: [
            BlocBuilder<ImageParallaxBloc, ImageParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .6.sh,
                  left: 0,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: BlocProvider.of<KeyHolderCubit>(context).state.paymentImageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_2.png',
                    fit: BoxFit.contain
                  )
                );
              }
            ),
          ],
        )
      )
    );
  }


  void _updateScroll({required BuildContext context, required ParallaxState parallaxState}) {
    BlocProvider.of<ImageParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(parentKey: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey, childKey: BlocProvider.of<KeyHolderCubit>(context).state.paymentImageKey);
    if (imageVisible != BlocProvider.of<ImageParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<ImageParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}