import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../bloc/background_parallax_bloc.dart';

class BackgroundImage extends StatefulWidget {

  final GlobalKey _businessListViewKey;

  final GlobalKey _firstImageWindowKey;
  final GlobalKey _firstImageWindowBottomKey;

  final GlobalKey _secondImageWindowKey;
  final GlobalKey _secondImageWindowBottomKey;

  final GlobalKey _thirdImageWindowKey;
  final GlobalKey _thirdImageWindowBottomKey;

  final GlobalKey _fourthImageWindowKey;

  const BackgroundImage({
    required GlobalKey businessListViewKey,
    required GlobalKey firstImageWindowKey,
    required GlobalKey firstImageWindowBottomKey,
    required GlobalKey secondImageWindowKey,
    required GlobalKey secondImageWindowBottomKey,
    required GlobalKey thirdImageWindowKey,
    required GlobalKey thirdImageWindowBottomKey,
    required GlobalKey fourthImageWindowKey

  })
    : _businessListViewKey = businessListViewKey,
      _firstImageWindowKey = firstImageWindowKey,
      _firstImageWindowBottomKey = firstImageWindowBottomKey,
      _secondImageWindowKey = secondImageWindowKey,
      _secondImageWindowBottomKey = secondImageWindowBottomKey,
      _thirdImageWindowKey = thirdImageWindowKey,
      _thirdImageWindowBottomKey = thirdImageWindowBottomKey,
      _fourthImageWindowKey = fourthImageWindowKey;

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}
  
class _BackgroundImageState extends State<BackgroundImage> {
  late BackgroundParallaxBloc _backgroundParallaxBloc;
  
  double get _screenWidth => MediaQuery.of(context).size.width;
  double get _screenHeight => MediaQuery.of(context).size.height;
  
  @override
  void initState() {
    super.initState();
    _backgroundParallaxBloc = BlocProvider.of<BackgroundParallaxBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackgroundParallaxBloc, BackgroundParallaxState>(
      listenWhen: (previousState, currentState) => previousState.absolutePositionY != currentState.absolutePositionY,
      listener: (context, state) {
        _handleScrollChanged(state: state);
      },
      builder: (context, state) {
        return Positioned(
          top: state.topOffset,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: state.currentImage,
            fit: BoxFit.cover,
            height: _screenHeight + state.constantTopMargin * 2,
            width: _screenWidth,
          ) 
        );
      },
    );
  }

  double _imageOffset({required GlobalKey windowKey, required RenderObject businessListViewObject}) {
    RenderObject imageWindow = windowKey.currentContext!.findRenderObject()!;
    return imageWindow.getTransformTo(businessListViewObject).getTranslation().y;
  }

  void _handleScrollChanged({required BackgroundParallaxState state}) {
    _setImage(absolutePositionY: state.absolutePositionY);
  }

  void _setImage({required double absolutePositionY}) {
    RenderObject businessListViewObject = widget._businessListViewKey.currentContext!.findRenderObject()!;
    final double listViewHeight = businessListViewObject.paintBounds.height;
    
    final double firstWindowOffset = _imageOffset(windowKey: widget._firstImageWindowKey, businessListViewObject: businessListViewObject);
    final double secondWindowOffset = _imageOffset(windowKey: widget._secondImageWindowKey, businessListViewObject: businessListViewObject);
    final double thirdWindowOffset = _imageOffset(windowKey: widget._thirdImageWindowKey, businessListViewObject: businessListViewObject);
    final double fourthWindowOffset = _imageOffset(windowKey: widget._fourthImageWindowKey, businessListViewObject: businessListViewObject);
    
    if (fourthWindowOffset < listViewHeight) {
      _fourthImageHandler(absolutePositionY: absolutePositionY);
    } else if (thirdWindowOffset < listViewHeight) {
      _thirdImageHandler(businessListViewObject: businessListViewObject, absolutePositionY: absolutePositionY);
    } else if (secondWindowOffset < listViewHeight) {
      _secondImageHandler(businessListViewObject: businessListViewObject, absolutePositionY: absolutePositionY);
    } else if (firstWindowOffset < listViewHeight) {
      _firstImageHandler(businessListViewObject: businessListViewObject, absolutePositionY: absolutePositionY);
    }
  }

  void _fourthImageHandler({required double absolutePositionY}) {
    if (_backgroundParallaxBloc.state.currentImage != BackgroundParallaxBloc.fourthImage) {
      _changeBackground(image: BackgroundParallaxBloc.fourthImage, absolutePositionY: absolutePositionY);
    }
  }

  void _thirdImageHandler({required RenderObject businessListViewObject, required double absolutePositionY}) {
    if (_backgroundParallaxBloc.state.currentImage == BackgroundParallaxBloc.secondImage) {
      _changeBackground(image: BackgroundParallaxBloc.thirdImage, absolutePositionY: absolutePositionY);
    } else if (_backgroundParallaxBloc.state.currentImage == BackgroundParallaxBloc.fourthImage) {
      double bottomThirdWindowOffset = _imageOffset(windowKey: widget._thirdImageWindowBottomKey, businessListViewObject: businessListViewObject);
      if (bottomThirdWindowOffset > 0 && _backgroundParallaxBloc.state.currentImage != BackgroundParallaxBloc.thirdImage) {
        _changeBackground(image: BackgroundParallaxBloc.thirdImage, absolutePositionY: absolutePositionY);
      }
    }
  }

  void _secondImageHandler({required RenderObject businessListViewObject, required double absolutePositionY}) {
    if (_backgroundParallaxBloc.state.currentImage == BackgroundParallaxBloc.firstImage) {
      _changeBackground(image: BackgroundParallaxBloc.secondImage, absolutePositionY: absolutePositionY);
    } else if (_backgroundParallaxBloc.state.currentImage == BackgroundParallaxBloc.thirdImage) {
      double bottomSecondWindowOffset = _imageOffset(windowKey: widget._secondImageWindowBottomKey, businessListViewObject: businessListViewObject);
      if (bottomSecondWindowOffset > 0 && _backgroundParallaxBloc.state.currentImage != BackgroundParallaxBloc.secondImage) {
        _changeBackground(image: BackgroundParallaxBloc.secondImage, absolutePositionY: absolutePositionY);
      }
    }
  }

  void _firstImageHandler({required RenderObject businessListViewObject, required double absolutePositionY}) {
    if (_backgroundParallaxBloc.state.currentImage == BackgroundParallaxBloc.secondImage) {
      double bottomFirstWindowOffset = _imageOffset(windowKey: widget._firstImageWindowBottomKey, businessListViewObject: businessListViewObject);
      if (bottomFirstWindowOffset > 0 && _backgroundParallaxBloc.state.currentImage != BackgroundParallaxBloc.firstImage) {
        _changeBackground(image: BackgroundParallaxBloc.firstImage, absolutePositionY: absolutePositionY);
      }
    }
  }

  void _changeBackground({required String image, required double absolutePositionY}) {
    _backgroundParallaxBloc.add(BackgroundImageChanged(
      image: image,
      constantEntryPositionY: absolutePositionY,
      constantEntryDistanceFromTop: _screenHeight
    ));
  }
}