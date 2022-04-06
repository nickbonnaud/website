import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/operation_row_parallax_bloc.dart';

class OperationImage extends StatelessWidget {
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const OperationImage({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
      child: SizedBox(
        height: .3.sh,
        width: _imageWidth(context: context),
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
                    ? _initialOffset(context: context).h
                    : state.parallaxOffset.h + _initialOffset(context: context).h,
                  child: FadeInImage.memoryNetwork(
                    key: BlocProvider.of<KeyHolderCubit>(context).state.faqsOperationImageKey,
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

  double _initialOffset({required BuildContext context}) {
    return ResponsiveWrapper.of(context).isSmallerThan(MOBILE)
      ? 50 : 100;
  }
  
  double _imageWidth({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .8.sw;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .7.sw;
    }
    return .6.sw;
  }

  void _updateScroll({required BuildContext context, required ParallaxState parallaxState}) {
    BlocProvider.of<OperationRowParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(parentKey: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey, childKey: BlocProvider.of<KeyHolderCubit>(context).state.faqsOperationImageKey);
    if (imageVisible != BlocProvider.of<OperationRowParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<OperationRowParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}