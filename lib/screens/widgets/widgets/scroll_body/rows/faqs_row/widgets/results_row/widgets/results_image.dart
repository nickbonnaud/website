import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

import '../bloc/results_row_parallax_bloc.dart';

class ResultsImage extends StatelessWidget {
  static const double _initialOffset = 200;
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const ResultsImage({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
      child: SizedBox(
        height: .7.sh,
        width: _imageWidth(context: context),
        child: Stack(
          children: [
            BlocBuilder<ResultsRowParallaxBloc, ResultsRowParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .5.sh,
                  right: 0,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: BlocProvider.of<KeyHolderCubit>(context).state.faqsResultsImageKey,
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

  double _imageWidth({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return .55.sw;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return .4.sw;
    }
    return .2.sw;
  }

  void _updateScroll({required BuildContext context, required ParallaxState parallaxState}) {
    BlocProvider.of<ResultsRowParallaxBloc>(context).add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(parentKey: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey, childKey: BlocProvider.of<KeyHolderCubit>(context).state.faqsResultsImageKey);
    if (imageVisible != BlocProvider.of<ResultsRowParallaxBloc>(context).state.isImageVisible) {
      BlocProvider.of<ResultsRowParallaxBloc>(context).add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}