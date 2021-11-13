import 'package:flutter/material.dart';

class TitleColumn extends StatefulWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const TitleColumn({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;
  
  @override
  State<TitleColumn> createState() => _TitleColumnState();
}

class _TitleColumnState extends State<TitleColumn> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _titleGlobalKey = GlobalKey();

  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _enterAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _enterAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero
    ).animate(_curvedAnimation);

    widget._scrollController.addListener(_updateTitleEnteredView);
  }
  
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      key: _titleGlobalKey,
      position: _enterAnimation,
      child: const Text(
        "Rates, Made Simple",
        style: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold
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

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? iconObject = _titleGlobalKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || iconObject == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double iconObjectTop = iconObject.getTransformTo(businessListViewObject).getTranslation().y;

    final bool iconVisible = (iconObjectTop + _enterAnimationMinHeight) < listViewHeight;

    if (iconVisible) {
      _animationController.forward();
    }
  }
}