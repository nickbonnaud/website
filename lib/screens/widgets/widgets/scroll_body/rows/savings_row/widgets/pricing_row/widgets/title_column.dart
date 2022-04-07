import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:website/resources/text_sizer.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/key_holder_cubit/key_holder_cubit.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

class TitleColumn extends StatefulWidget {

  const TitleColumn({Key? key})
    : super(key: key);
  
  @override
  State<TitleColumn> createState() => _TitleColumnState();
}

class _TitleColumnState extends State<TitleColumn> with SingleTickerProviderStateMixin {
  final TextSizer _textSizer = const TextSizer();
  final VisibilityFinder _visibilityFinder = const VisibilityFinder(enterAnimationMinHeight: 100);

  late final AnimationController _animationController;
  late final Animation<Offset> _enterAnimation;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _enterAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0),
      end: Offset.zero
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (contexy, state) {
        _updateTitleEnteredView();
      },
      child: SlideTransition(
        key: BlocProvider.of<KeyHolderCubit>(context).state.pricingTitleKey,
        position: _enterAnimation,
        child: RichText(
          text: TextSpan(
            text: "Rates, Made ",
            style: TextStyle(
              fontSize: _textSize(),
              fontWeight: FontWeight.bold
            ),
            children: const [
              TextSpan(
                text: "Simple",
                style: TextStyle(
                  color: Color.fromRGBO(28, 132, 26, 1)
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _textSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 70.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan('LARGE_MOBILE')) {
      return 50.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 40.sp;
    }
    return 50.sp;
  }

  void _updateTitleEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    KeyHolderCubit cubit = BlocProvider.of<KeyHolderCubit>(context);
    
    bool iconVisible = _visibilityFinder.isVisible(parentKey: cubit.state.mainScrollKey, childKey: cubit.state.pricingTitleKey);

    if (iconVisible) {
      _animationController.forward();
    }
  }
}