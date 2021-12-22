import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';
import 'package:website/screens/widgets/widgets/faqs_row/faqs_row.dart';
import 'package:website/screens/widgets/widgets/intro_row/intro_row.dart';

import 'widgets/dashboard_row/dashboard_row.dart';
import 'widgets/get_started_button/cubit/get_started_button_cubit.dart';
import 'widgets/get_started_button/get_started_button.dart';
import 'widgets/savings_row/savings_row.dart';
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
  final GlobalKey _fourthImageWindowKey = GlobalKey();

  late ParallaxBloc _parallaxBloc;

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _integrationKey = GlobalKey();
  final GlobalKey _faqsKey = GlobalKey();
  
  double get _screenWidth => MediaQuery.of(context).size.width;
  double get _screenHeight => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    _parallaxBloc = BlocProvider.of<ParallaxBloc>(context);
    _scrollController.addListener(_handleScrollNotification);
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _backgroundImage(),
        _imageText(),
        _scrollableBody()
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _parallaxBloc.close();
    super.dispose();
  }

  Widget _backgroundImage() {
    return BlocBuilder<ParallaxBloc, ParallaxState>(
      builder: (context, state) {
        return Positioned(
          top: -.25 * (state.offset.h - state.offsetAdjustment.h),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: state.currentBackground,
            fit: BoxFit.fitWidth,
            height: _screenHeight,
            width: _screenWidth,
          )
        ); 
      }
    );
  }
  
  Widget _scrollableBody() {
    return CustomScrollView(
      key: _businessListViewKey,
      shrinkWrap: true,
      controller: _scrollController,
      slivers: [
        _appBar(),
        SliverToBoxAdapter(
          key: _firstImageWindowKey,
          child: SizedBox(
            height: _screenHeight,
            child: _titleText(),
          )
        ),
        SliverToBoxAdapter(
          key: _aboutKey,
          child: IntroRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _secondImageWindowKey,
          child: SizedBox(height: _screenHeight),
        ),
        SliverToBoxAdapter(
          key: _pricingKey,
          child: SavingsRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _thirdImageWindowKey,
          child: SizedBox(height: _screenHeight),
        ),
        SliverToBoxAdapter(
          key: _integrationKey,
          child: DashboardRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _fourthImageWindowKey,
          child: SizedBox(height: _screenHeight),
        ),
        SliverToBoxAdapter(
          key: _faqsKey,
          child: FaqsRow(businessListViewKey: _businessListViewKey)
        ),
      ],
    );
  }
  
  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: const Color(0xfff5f5f3),
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 5.h),
        child: const Image(image: AssetImage('assets/abstract_logo.png')),
      ),
      floating: true,
      snap: true,
      actions: [
        TextButton(
          onPressed: () => _goToSection(sectionKey: _aboutKey),
          child: const Text(
            "About",
          )
        ),
        TextButton(
          onPressed: () => _goToSection(sectionKey: _pricingKey),
          child: const Text(
            "Prices"
          )
        ),
        TextButton(
          onPressed: () => _goToSection(sectionKey: _integrationKey),
          child: const Text(
            "Integrate"
          )
        ),
        TextButton(
          onPressed: () => _goToSection(sectionKey: _faqsKey),
          child: const Text(
            "FAQs"
          )
        )
      ],
    );
  }
  
  Widget _titleText() {
    return BlocBuilder<ParallaxBloc, ParallaxState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              right: 50.w,
              top: 1.25 * (state.offset.h - state.offsetAdjustment.h) + (
                ResponsiveWrapper.of(context).isSmallerThan(TABLET) 
                  ? .55.sh : ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                  ? .5.sh : .6.sh
              ),
              child: ScrollDown()
            ),
            Positioned(
              left: 0,
              right: 0,
              top: .5 * (state.offset.h - state.offsetAdjustment.h) + .4.sh,
              child: Align(
                alignment: Alignment.center,
                child: Column(
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
                    SizedBox(height: 20.h),
                    BlocProvider<GetStartedButtonCubit>(
                      create: (_) => GetStartedButtonCubit(),
                      child: GetStartedButton(),
                    )
                  ],
                )
              )
            )
          ],
        );
      }
    );
  }
  
  Widget _imageText() {
    return BlocBuilder<ParallaxBloc, ParallaxState>(
      builder: (context, state) {
        if (state.currentBackground == ParallaxBloc.secondImage) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: -.5 * ((state.offset.h - state.offsetAdjustment.h) - 200.h),
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
                top: -.5 * ((state.offset.h - state.offsetAdjustment.h) - 400.h),
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
        } else if (state.currentBackground == ParallaxBloc.thirdImage) {
          return Positioned(
            left: 0,
            right: 0,
            top: -(state.offsetAdjustment.h - state.offset.h) + 200.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "An all in one solution.",
                style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )
            )
          );
        } else if (state.currentBackground == ParallaxBloc.fourthImage) {
          return Positioned(
            left: 0,
            right: 0,
            top: .2 * (state.offsetAdjustment.h - state.offset.h) + 300.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Ready To Get Started?",
                style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )
            )
          );
        } else {
          return Container();
        }
      }
    );
  }
  
  void _handleScrollNotification() {
    _setImage(offset: _scrollController.offset);
    _parallaxBloc.add(ScrollUpdated(offset: _scrollController.offset));
  }

  void _goToSection({required GlobalKey sectionKey}) {
    int offset = (_imageOffset(windowKey: sectionKey, businessListViewObject: _businessListViewKey.currentContext!.findRenderObject()!) - _scrollController.offset).round().abs();
    int duration = (offset / (_screenHeight / 2)).round();
    duration = duration == 0 ? 500 : duration * 150;
    Scrollable.ensureVisible(sectionKey.currentContext!, duration: Duration(milliseconds: duration), curve: Curves.easeOut);
  }
  
  void _goToSignup() {
    print('signup');
  }

  void _setImage({required double offset}) {
    RenderObject businessListViewObject = _businessListViewKey.currentContext!.findRenderObject()!;
    final double listViewHeight = businessListViewObject.paintBounds.height;
    
    final double firstWindowOffset = _imageOffset(windowKey: _firstImageWindowKey, businessListViewObject: businessListViewObject);
    final double secondWindowOffset = _imageOffset(windowKey: _secondImageWindowKey, businessListViewObject: businessListViewObject);
    final double thirdWindowOffset = _imageOffset(windowKey: _thirdImageWindowKey, businessListViewObject: businessListViewObject);
    final double fourthWindowOffset = _imageOffset(windowKey: _fourthImageWindowKey, businessListViewObject: businessListViewObject);

    if (fourthWindowOffset < listViewHeight) {
      if (_parallaxBloc.state.currentBackground != ParallaxBloc.fourthImage) {
        _parallaxBloc.add(BackgroundChanged(
          newBackground: ParallaxBloc.fourthImage,
          currentOffset: offset,
          offsetAdjustment: offset + 600.h
        ));
      }
    } else if (thirdWindowOffset < listViewHeight) {
      if (_parallaxBloc.state.currentBackground != ParallaxBloc.thirdImage) {
        double offsetAdjustment = _parallaxBloc.state.currentBackground == ParallaxBloc.secondImage
          ? 600.h
          : -2000.h;
        _parallaxBloc.add(BackgroundChanged(
          newBackground: ParallaxBloc.thirdImage,
          currentOffset: offset,
          offsetAdjustment: offset + offsetAdjustment
        ));
      }
    } else if (secondWindowOffset < listViewHeight) {
      if (_parallaxBloc.state.currentBackground != ParallaxBloc.secondImage) {
        double offsetAdjustment = _parallaxBloc.state.currentBackground == ParallaxBloc.firstImage
          ? 600.h
          : -1800.h;
        _parallaxBloc.add(BackgroundChanged(
          newBackground: ParallaxBloc.secondImage,
          currentOffset: offset,
          offsetAdjustment: offset + offsetAdjustment
        ));
      }
    } else if (firstWindowOffset < listViewHeight) {
      if (_parallaxBloc.state.currentBackground != ParallaxBloc.firstImage) {
        _parallaxBloc.add(BackgroundChanged(
          newBackground: ParallaxBloc.firstImage,
          currentOffset: offset,
          offsetAdjustment: 0
        ));
      }
    }
  }

  
  double _imageOffset({required GlobalKey windowKey, required RenderObject businessListViewObject}) {
    RenderObject imageWindow = windowKey.currentContext!.findRenderObject()!;
    return imageWindow.getTransformTo(businessListViewObject).getTranslation().y;
  }
}