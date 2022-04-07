import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';

class MainAppBar extends StatelessWidget {
  final ScrollController _scrollController;

  const MainAppBar({required ScrollController scrollController, Key? key})
    : _scrollController = scrollController,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xfff5f5f3),
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: '/assets/abstract_logo.png',
          fit: BoxFit.contain,
        )
      ),
      floating: true,
      snap: true,
      actions: [
        TextButton(
          onPressed: () => _goToSection(
            context: context,
            sectionKey: BlocProvider.of<KeyHolderCubit>(context).state.aboutKey
          ),
          child: Text(
            "About",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(
            context: context,
            sectionKey: BlocProvider.of<KeyHolderCubit>(context).state.pricingKey
          ),
          child: Text(
            "Prices",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(
            context: context,
            sectionKey: BlocProvider.of<KeyHolderCubit>(context).state.integrationKey
          ),
          child: Text(
            "Integrate",
            style: TextStyle(
              fontSize: _textSize(context: context)
            ),
          )
        ),
        TextButton(
          onPressed: () => _goToSection(
            context: context,
            sectionKey: BlocProvider.of<KeyHolderCubit>(context).state.faqsKey
          ),
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
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 36.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 30.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 28.sp;
    }
    return 24.sp;
  }

  void _goToSection({required BuildContext context, required GlobalKey sectionKey}) {
    int offset = (_imageOffset(windowKey: sectionKey, businessListViewObject: BlocProvider.of<KeyHolderCubit>(context).state.mainScrollKey.currentContext!.findRenderObject()!) - _scrollController.offset).round().abs();
    int duration = (offset / (MediaQuery.of(context).size.height / 2)).round();
    duration = duration == 0 ? 500 : duration * 150;
    Scrollable.ensureVisible(sectionKey.currentContext!, duration: Duration(milliseconds: duration), curve: Curves.easeOut);
  }

  void _goToDashboard() {
    // TODO
    // add go to dashboard
  }
}