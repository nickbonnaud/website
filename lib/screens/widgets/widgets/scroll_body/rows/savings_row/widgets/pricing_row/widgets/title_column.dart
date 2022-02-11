import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/resources/text_sizer.dart';
import 'package:website/resources/visibility_finder.dart';
import 'package:website/screens/parallax_bloc/parallax_bloc.dart';

class TitleColumn extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const TitleColumn({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;
  
  @override
  State<TitleColumn> createState() => _TitleColumnState();
}

class _TitleColumnState extends State<TitleColumn> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final TextSizer _textSizer = TextSizer();
  final GlobalKey _titleGlobalKey = GlobalKey();

  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _enterAnimation;

  late VisibilityFinder _visibilityFinder;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _enterAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0),
      end: Offset.zero
    ).animate(_curvedAnimation);

    _visibilityFinder = VisibilityFinder(parentKey: widget._businessListViewKey, childKey: _titleGlobalKey, enterAnimationMinHeight: _enterAnimationMinHeight);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (contexy, state) {
        _updateTitleEnteredView();
      },
      child: SlideTransition(
        key: _titleGlobalKey,
        position: _enterAnimation,
        child: RichText(
          text: TextSpan(
            text: "Rates, Made ",
            style: TextStyle(
              fontSize: _textSizer.fullRowHeader(context: context),
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

  void _updateTitleEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    bool iconVisible = _visibilityFinder.isVisible();

    if (iconVisible) {
      _animationController.forward();
    }
  }
}