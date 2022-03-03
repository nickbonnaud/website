import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class MainAppBar extends StatelessWidget {
  final ScrollController _scrollController;

  final GlobalKey _businessListViewKey;

  final GlobalKey _aboutKey;
  final GlobalKey _pricingKey;
  final GlobalKey _integrationKey;
  final GlobalKey _faqsKey;

  const MainAppBar({
    required ScrollController scrollController,
    required GlobalKey businessListViewKey,
    required GlobalKey aboutKey,
    required GlobalKey pricingKey,
    required GlobalKey integrationKey,
    required GlobalKey faqsKey
  })
    : _scrollController = scrollController,
      _businessListViewKey = businessListViewKey,
      _aboutKey = aboutKey,
      _pricingKey = pricingKey,
      _integrationKey = integrationKey,
      _faqsKey = faqsKey;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xfff5f5f3),
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: const Image(
          image: AssetImage('assets/abstract_logo.png'),
          fit: BoxFit.contain,
        ),
      ),
      floating: true,
      snap: true,
      actions: [
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _aboutKey),
          child: Text(
            "About",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _pricingKey),
          child: Text(
            "Prices",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _integrationKey),
          child: Text(
            "Integrate",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _faqsKey),
          child: Text(
            "FAQs",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        const VerticalDivider(),
        TextButton(
          onPressed: () => _goToDashboard(),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        )
      ],
    );
  }
  
  double _imageOffset({required GlobalKey windowKey, required RenderObject businessListViewObject}) {
    RenderObject imageWindow = windowKey.currentContext!.findRenderObject()!;
    return imageWindow.getTransformTo(businessListViewObject).getTranslation().y;
  }

  double _textSize({required BuildContext context}) {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 48.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 32.sp;
    }
    return 24.sp;
  }

  void _goToSection({required BuildContext context, required GlobalKey sectionKey}) {
    int offset = (_imageOffset(windowKey: sectionKey, businessListViewObject: _businessListViewKey.currentContext!.findRenderObject()!) - _scrollController.offset).round().abs();
    int duration = (offset / (MediaQuery.of(context).size.height / 2)).round();
    duration = duration == 0 ? 500 : duration * 150;
    Scrollable.ensureVisible(sectionKey.currentContext!, duration: Duration(milliseconds: duration), curve: Curves.easeOut);
  }

  void _goToDashboard() {
    // TODO
    // add go to dashboard
  }
}