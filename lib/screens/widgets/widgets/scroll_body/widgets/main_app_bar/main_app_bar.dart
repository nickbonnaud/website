import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.only(left: 20.w, top: 5.h, bottom: 5.h),
        child: const Image(image: AssetImage('assets/abstract_logo.png')),
      ),
      floating: true,
      snap: true,
      actions: [
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _aboutKey),
          child: const Text(
            "About",
          )
        ),
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _pricingKey),
          child: const Text(
            "Prices"
          )
        ),
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _integrationKey),
          child: const Text(
            "Integrate"
          )
        ),
        TextButton(
          onPressed: () => _goToSection(context: context, sectionKey: _faqsKey),
          child: const Text(
            "FAQs"
          )
        )
      ],
    );
  }

  void _goToSection({required BuildContext context, required GlobalKey sectionKey}) {
    int offset = (_imageOffset(windowKey: sectionKey, businessListViewObject: _businessListViewKey.currentContext!.findRenderObject()!) - _scrollController.offset).round().abs();
    int duration = (offset / (MediaQuery.of(context).size.height / 2)).round();
    duration = duration == 0 ? 500 : duration * 150;
    Scrollable.ensureVisible(sectionKey.currentContext!, duration: Duration(milliseconds: duration), curve: Curves.easeOut);
  }

  double _imageOffset({required GlobalKey windowKey, required RenderObject businessListViewObject}) {
    RenderObject imageWindow = windowKey.currentContext!.findRenderObject()!;
    return imageWindow.getTransformTo(businessListViewObject).getTranslation().y;
  }
}