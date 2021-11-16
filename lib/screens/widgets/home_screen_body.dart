import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';
import 'package:website/screens/widgets/widgets/business_data_row/business_data_row.dart';
import 'package:website/screens/widgets/widgets/faqs_row/faqs_row.dart';

import 'widgets/savings_row/savings_row.dart';
import 'widgets/pricing_row/pricing_row.dart';
import 'widgets/scroll_down/scroll_down.dart';
import 'widgets/typical_savings_number/bloc/typical_savings_number_bloc.dart';
import 'widgets/typical_savings_number/typical_savings_number.dart';
import 'widgets/typical_savings_title/cubit/typical_savings_title_cubit.dart';
import 'widgets/typical_savings_title/typical_savings_title.dart';

class HomeScreenBody extends StatefulWidget {
  
  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _businessListViewKey = GlobalKey();
  final GlobalKey _firstImageWindowKey = GlobalKey();
  final GlobalKey _secondImageWindowKey = GlobalKey();
  final GlobalKey _thirdImageWindowKey = GlobalKey();

  late ParallaxBloc _parallaxBloc;
  
  double get _screenWidth => MediaQuery.of(context).size.width;
  double get _screenHeight => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<ParallaxBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: BlocBuilder<ParallaxBloc, ParallaxState>(
        builder: (context, state) {
          return Stack(
            children: [
              _backgroundImage(state: state),
              _imageText(state: state),
              _scrollableBody(state: state)
            ],
          );
        }
      )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _backgroundImage({required ParallaxState state}) {
    return Positioned(
      top: -.25 * (state.offset - state.offsetAdjustment),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: state.currentBackground,
        fit: BoxFit.fitWidth,
        height: _screenHeight,
        width: _screenWidth,
      )
    );
  }
  
  Widget _scrollableBody({required ParallaxState state}) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, isOk) {
        return [
          _appBar()
        ];
      },
      body: ListView(
        key: _businessListViewKey,
        cacheExtent: 100,
        addAutomaticKeepAlives: false,
        children: [
          SizedBox(
            key: _firstImageWindowKey,
            height: _screenHeight,
            child: _titleText(state: state),
          ),
          BusinessDataRow(businessListViewKey: _businessListViewKey),
          const SizedBox(
            height: 40.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          PricingRow(businessListViewKey: _businessListViewKey),
          SizedBox(key: _secondImageWindowKey, height: _screenHeight),
          SavingsRow(businessListViewKey: _businessListViewKey),
          SizedBox(key: _thirdImageWindowKey, height: _screenHeight),
          FaqsRow()
        ],
      )
    );
  }
  
  Widget _titleText({required ParallaxState state}) {
    return Stack(
      children: [
        Positioned(
          right: 50.w,
          top: 1.25 * (state.offset.h - state.offsetAdjustment.h) + .7.sh,
          child: ScrollDown()
        ),
        Positioned(
          left: 0,
          right: 0,
          top: .5 * (state.offset.h - state.offsetAdjustment.h) + .4.sh,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Nova Pay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 56.sp
                  ),
                ),
                SizedBox(width: 35.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
                  ),
                  onPressed: () => _goToSignup(), 
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp
                  ),
                  )
                )
              ],
            )
          )
        )
      ],
    );
  }

  Widget _appBar() {
    return const SliverAppBar(
      title: Text("Hello world"),
      floating: true,
      snap: true,
      actions: [],
    );
  }
  
  Widget _imageText({required ParallaxState state}) {
    if (state.currentBackground == ParallaxBloc.secondImage) {
      return Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: -2 * (state.offset.h - state.offsetAdjustment.h) - 150.h,
            child: Align(
              alignment: Alignment.center,
              child: BlocProvider<TypicalSavingsTitleCubit>(
                create: (_) => TypicalSavingsTitleCubit(),
                child: TypicalSavingsTitle(
                  businessListViewKey: _businessListViewKey,
                  secondImageWindowKey: _secondImageWindowKey,
                ),
              ),
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -1.5 * (state.offset.h - state.offsetAdjustment.h),
            child: Align(
              alignment: Alignment.center,
              child: BlocProvider<TypicalSavingsNumberBloc>(
                create: (_) => TypicalSavingsNumberBloc(),
                child: TypicalSavingsNumber(
                  businessListViewKey: _businessListViewKey,
                  secondImageWindowKey: _secondImageWindowKey,
                ),
              )
            )
          ),
        ],
      );
    } else {
      return Container();
    }
  }
  
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _resetImage(notification: notification);
      _parallaxBloc.add(ScrollUpdated(offset: notification.metrics.pixels));
    }

    return false;
  }

  void _goToSignup() {
    print('Go To Signup');
  }
  
  void _resetImage({required ScrollNotification notification}) {
    if (_firstImageVisible(offset: notification.metrics.pixels)) return;
    if (_secondImageVisible(offset: notification.metrics.pixels)) return;
    if (_thirdImageVisible(offset: notification.metrics.pixels)) return;
  }

  bool _firstImageVisible({required double offset}) {
    RenderObject? businessListViewObject = _businessListViewKey.currentContext?.findRenderObject();
    RenderObject? firstImageWindowKey = _firstImageWindowKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || firstImageWindowKey == null) return false;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double objectTop = firstImageWindowKey.getTransformTo(businessListViewObject).getTranslation().y;

    if (objectTop < listViewHeight && _parallaxBloc.state.currentBackground != ParallaxBloc.firstImage) {
      _parallaxBloc.add(BackgroundChanged(
        newBackground: ParallaxBloc.firstImage,
        currentOffset: offset,
        offsetAdjustment: 0
      ));
      return true;
    }
    return false;
  }

  bool _secondImageVisible({required double offset}) {
    RenderObject? businessListViewObject = _businessListViewKey.currentContext?.findRenderObject();
    RenderObject? secondImageWindowKey = _secondImageWindowKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || secondImageWindowKey == null) return false;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double objectTop = secondImageWindowKey.getTransformTo(businessListViewObject).getTranslation().y;

    if (objectTop < listViewHeight && _parallaxBloc.state.currentBackground != ParallaxBloc.secondImage) {
      double offsetAdjustment = _parallaxBloc.state.currentBackground == ParallaxBloc.firstImage
        ? 800.h
        : -500.h;
      _parallaxBloc.add(BackgroundChanged(
        newBackground: ParallaxBloc.secondImage,
        currentOffset: offset,
        offsetAdjustment: offset + offsetAdjustment
      ));
      return true;
    }
    return false;
  }

  bool _thirdImageVisible({required double offset}) {
    RenderObject? businessListViewObject = _businessListViewKey.currentContext?.findRenderObject();
    RenderObject? thirdImageWindowKey = _thirdImageWindowKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || thirdImageWindowKey == null) return false;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double objectTop = thirdImageWindowKey.getTransformTo(businessListViewObject).getTranslation().y;

    if (objectTop < listViewHeight && _parallaxBloc.state.currentBackground != ParallaxBloc.thirdImage) {
      _parallaxBloc.add(BackgroundChanged(
        newBackground: ParallaxBloc.thirdImage,
        currentOffset: offset,
        offsetAdjustment: offset + 500.h
      ));
      return true;
    }
    return false;
  }
}