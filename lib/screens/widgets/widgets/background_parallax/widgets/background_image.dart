import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';

import '../bloc/background_parallax_bloc.dart';

class BackgroundImage extends StatelessWidget {

  const BackgroundImage({ Key? key})
    : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackgroundParallaxBloc, BackgroundParallaxState>(
      listenWhen: (previousState, currentState) => previousState.absolutePositionY != currentState.absolutePositionY,
      listener: (context, state) {
        _handleScrollChanged(context: context, state: state);
      },
      builder: (context, state) {
        return Positioned(
          top: state.topOffset,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: state.currentImage,
            fit: BoxFit.cover,
            height: _screenHeight(context: context) + state.constantTopMargin * 2,
            width: _screenWidth(context: context),
          ) 
        );
      },
    );
  }

  double _screenWidth({required BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  double _screenHeight({required BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }
  
  double _imageOffset({required GlobalKey windowKey, required RenderObject businessListViewObject}) {
    RenderObject imageWindow = windowKey.currentContext!.findRenderObject()!;
    return imageWindow.getTransformTo(businessListViewObject).getTranslation().y;
  }

  void _handleScrollChanged({required BuildContext context, required BackgroundParallaxState state}) {
    _setImage(context: context, absolutePositionY: state.absolutePositionY);
  }

  void _setImage({required BuildContext context, required double absolutePositionY}) {
    KeyHolderCubit cubit = BlocProvider.of<KeyHolderCubit>(context);
    RenderObject businessListViewObject = cubit.state.mainScrollKey.currentContext!.findRenderObject()!;
    final double listViewHeight = businessListViewObject.paintBounds.height;
    
    final double firstWindowOffset = _imageOffset(windowKey: cubit.state.firstImageWindowKey, businessListViewObject: businessListViewObject);
    final double secondWindowOffset = _imageOffset(windowKey: cubit.state.secondImageWindowKey, businessListViewObject: businessListViewObject);
    final double thirdWindowOffset = _imageOffset(windowKey: cubit.state.thirdImageWindowKey, businessListViewObject: businessListViewObject);
    final double fourthWindowOffset = _imageOffset(windowKey: cubit.state.fourthImageWindowKey, businessListViewObject: businessListViewObject);
    
    if (fourthWindowOffset < listViewHeight) {
      _fourthImageHandler(context: context, absolutePositionY: absolutePositionY);
    } else if (thirdWindowOffset < listViewHeight) {
      _thirdImageHandler(context: context, businessListViewObject: businessListViewObject, absolutePositionY: absolutePositionY, cubit: cubit);
    } else if (secondWindowOffset < listViewHeight) {
      _secondImageHandler(context: context, businessListViewObject: businessListViewObject, absolutePositionY: absolutePositionY, cubit: cubit);
    } else if (firstWindowOffset < listViewHeight) {
      _firstImageHandler(context: context, businessListViewObject: businessListViewObject, absolutePositionY: absolutePositionY, cubit: cubit);
    }
  }

  void _fourthImageHandler({required BuildContext context, required double absolutePositionY}) {
    if ( BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage != BackgroundParallaxBloc.fourthImage) {
      _changeBackground(context: context, image: BackgroundParallaxBloc.fourthImage, absolutePositionY: absolutePositionY);
    }
  }

  void _thirdImageHandler({required BuildContext context, required RenderObject businessListViewObject, required double absolutePositionY, required KeyHolderCubit cubit}) {
    if ( BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage == BackgroundParallaxBloc.secondImage) {
      _changeBackground(context: context, image: BackgroundParallaxBloc.thirdImage, absolutePositionY: absolutePositionY);
    } else if ( BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage == BackgroundParallaxBloc.fourthImage) {
      double bottomThirdWindowOffset = _imageOffset(windowKey: cubit.state.thirdImageWindowBottomKey, businessListViewObject: businessListViewObject);
      if (bottomThirdWindowOffset > 0 &&  BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage != BackgroundParallaxBloc.thirdImage) {
        _changeBackground(context: context, image: BackgroundParallaxBloc.thirdImage, absolutePositionY: absolutePositionY);
      }
    }
  }

  void _secondImageHandler({required BuildContext context, required RenderObject businessListViewObject, required double absolutePositionY, required KeyHolderCubit cubit}) {
    if ( BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage == BackgroundParallaxBloc.firstImage) {
      _changeBackground(context: context, image: BackgroundParallaxBloc.secondImage, absolutePositionY: absolutePositionY);
    } else if ( BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage == BackgroundParallaxBloc.thirdImage) {
      double bottomSecondWindowOffset = _imageOffset(windowKey: cubit.state.secondImageWindowBottomKey, businessListViewObject: businessListViewObject);
      if (bottomSecondWindowOffset > 0 &&  BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage != BackgroundParallaxBloc.secondImage) {
        _changeBackground(context: context, image: BackgroundParallaxBloc.secondImage, absolutePositionY: absolutePositionY);
      }
    }
  }

  void _firstImageHandler({required BuildContext context, required RenderObject businessListViewObject, required double absolutePositionY, required KeyHolderCubit cubit}) {
    if ( BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage == BackgroundParallaxBloc.secondImage) {
      double bottomFirstWindowOffset = _imageOffset(windowKey: cubit.state.firstImageWindowBottomKey, businessListViewObject: businessListViewObject);
      if (bottomFirstWindowOffset > 0 &&  BlocProvider.of<BackgroundParallaxBloc>(context).state.currentImage != BackgroundParallaxBloc.firstImage) {
        _changeBackground(context: context, image: BackgroundParallaxBloc.firstImage, absolutePositionY: absolutePositionY);
      }
    }
  }

  void _changeBackground({required BuildContext context, required String image, required double absolutePositionY}) {
     BlocProvider.of<BackgroundParallaxBloc>(context).add(BackgroundImageChanged(
      image: image,
      constantEntryPositionY: absolutePositionY,
      constantEntryDistanceFromTop: _screenHeight(context: context)
    ));
  }
}