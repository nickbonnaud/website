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

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _savingsKey = GlobalKey();
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
          child: BusinessDataRow(businessListViewKey: _businessListViewKey),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 40.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
        ),
        SliverToBoxAdapter(
          key: _pricingKey,
          child: PricingRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _secondImageWindowKey,
          child: SizedBox(height: _screenHeight),
        ),
        SliverToBoxAdapter(
          key: _savingsKey,
          child: SavingsRow(businessListViewKey: _businessListViewKey),
        ),
        SliverToBoxAdapter(
          key: _thirdImageWindowKey,
          child: SizedBox(height: _screenHeight),
        ),
        SliverToBoxAdapter(
          key: _faqsKey,
          child: FaqsRow()
        ),
      ],
    );
  }
  
  Widget _appBar() {
    return SliverAppBar(
      title: const Text("Hello world"),
      floating: true,
      snap: true,
      actions: [
        TextButton(
          onPressed: () => _goToSection(sectionKey: _aboutKey),
          child: const Text(
            "About",
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(sectionKey: _pricingKey),
          child: const Text(
            "Prices",
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(sectionKey: _savingsKey),
          child: const Text(
            "Savings",
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(sectionKey: _faqsKey),
          child: const Text(
            "FAQs",
            style: TextStyle(
              color: Colors.white
            ),
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
        } else if (state.currentBackground == ParallaxBloc.thirdImage) {
          return Positioned(
            left: 0,
            right: 0,
            top: -(state.offsetAdjustment.h - state.offset.h ) + 200.h,
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

    if (thirdWindowOffset < listViewHeight) {
      if (_parallaxBloc.state.currentBackground != ParallaxBloc.thirdImage) {
        _parallaxBloc.add(BackgroundChanged(
          newBackground: ParallaxBloc.thirdImage,
          currentOffset: offset,
          offsetAdjustment: offset + 600.h
        ));
      }
    } else if (secondWindowOffset < listViewHeight) {
      if (_parallaxBloc.state.currentBackground != ParallaxBloc.secondImage) {
        double offsetAdjustment = _parallaxBloc.state.currentBackground == ParallaxBloc.firstImage
          ? 800.h
          : -900.h;
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