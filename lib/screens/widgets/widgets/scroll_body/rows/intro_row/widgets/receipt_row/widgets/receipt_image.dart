import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';
import '../bloc/receipt_image_parallax_bloc.dart';

class ReceiptImage extends StatelessWidget {
  static const double _initialOffset = 200;
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 0);

  const ReceiptImage({Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(context: context, parallaxState: parallaxState),
      child: SizedBox(
        height: .6.sh,
        width: .2.sw,
        child: Stack(
          children: [
            BlocBuilder<ReceiptImageParallaxBloc, ReceiptImageParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: .5.sh,
                  left: ResponsiveWrapper.of(context).isSmallerThan(MOBILE) ? null : 0,
                  right: ResponsiveWrapper.of(context).isSmallerThan(MOBILE) ? 0 : null,
                  top: state.entryPosition == null
                    ? _initialOffset.h
                    : state.parallaxOffset.h + _initialOffset.h,
                  child: FadeInImage.memoryNetwork(
                    key: BlocProvider.of<KeyHolderCubit>(context).state.receiptImageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_4.png',
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
    ReceiptImageParallaxBloc parallaxBloc =  BlocProvider.of<ReceiptImageParallaxBloc>(context);
    parallaxBloc.add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    KeyHolderCubit keyHoldercubit = BlocProvider.of<KeyHolderCubit>(context);
    
    bool imageVisible = _visibilityFinder.isVisible(parentKey: keyHoldercubit.state.mainScrollKey, childKey: keyHoldercubit.state.receiptImageKey);
    if (imageVisible != parallaxBloc.state.isImageVisible) {
      parallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}