import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/resources/helpers/visibility_finder.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';
import '../bloc/receipt_image_parallax_bloc.dart';

class ReceiptImage extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const ReceiptImage({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey; 

  @override
  State<ReceiptImage> createState() => _ReceiptImageState();
}

class _ReceiptImageState extends State<ReceiptImage> {
  static final _initialOffset = 100.h;
  final GlobalKey _imageKey = GlobalKey();

  late ReceiptImageParallaxBloc _imageParallaxBloc;
  late VisibilityFinder _visibilityFinder;
  
  @override
  void initState() {
    _imageParallaxBloc = BlocProvider.of<ReceiptImageParallaxBloc>(context);
    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _imageKey);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listener: (context, parallaxState) => _updateScroll(parallaxState: parallaxState),
      child: SizedBox(
        height: .8.sh,
        width: .4.sw,
        child: Stack(
          children: [
            BlocBuilder<ReceiptImageParallaxBloc, ReceiptImageParallaxState>(
              buildWhen: (_, currentState) => currentState.isImageVisible,
              builder: (context, state) {
                return Positioned(
                  height: 1.5.sh,
                  left: 0,
                  top: state.entryPosition == null
                    ? _initialOffset
                    : _imageParallaxBloc.parallaxOffset + _initialOffset,
                  child: FadeInImage.memoryNetwork(
                    key: _imageKey,
                    placeholder: kTransparentImage,
                    image: '/assets/phone_app/phone_4.png',
                    fit: BoxFit.fitHeight,
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
    _imageParallaxBloc.close();
    super.dispose();
  }

  void _updateScroll({required ParallaxState parallaxState}) {
    _imageParallaxBloc.add(CurrentPositionChanged(currentPosition: parallaxState.offset));

    bool imageVisible = _visibilityFinder.isVisible(initialOffset: _initialOffset);
    if (imageVisible != _imageParallaxBloc.state.isImageVisible) {
      _imageParallaxBloc.add(ImageVisibilityChanged(
        isImageVisible: imageVisible,
        entryPosition: imageVisible ? parallaxState.offset : null
      ));
    }
  }
}