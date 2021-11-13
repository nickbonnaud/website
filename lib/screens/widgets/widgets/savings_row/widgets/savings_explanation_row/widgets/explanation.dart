import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Explanation extends StatefulWidget {
  final String _text;
  final AnimatedIconData _iconData;
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const Explanation({
    required String text,
    required AnimatedIconData iconData,
    required GlobalKey businessListViewKey,
    required ScrollController scrollController
  })
    : _text = text,
      _iconData = iconData,
      _businessListViewKey = businessListViewKey,
      _scrollController = scrollController; 

  @override
  State<Explanation> createState() => _ExplanationState();
}

class _ExplanationState extends State<Explanation> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _iconGlobalKey = GlobalKey();
  
  late AnimationController _iconController;
  
  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    widget._scrollController.addListener(_didEnterView);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _icon(),
        SizedBox(height: 10.h),
        _text()
      ],
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  Widget _icon() {
    return AnimatedIcon(
      key: _iconGlobalKey,
      size: .1.sw,
      icon: widget._iconData,
      progress: _iconController
    );
  }

  Widget _text() {
    return Text(
      widget._text,
      style: TextStyle(
        fontSize: 28.sp
      ),
    );
  }
  
  void _didEnterView() {
    if (_iconController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? iconObject = _iconGlobalKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || iconObject == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double iconObjectTop = iconObject.getTransformTo(businessListViewObject).getTranslation().y;

    final bool iconVisible = (iconObjectTop + _enterAnimationMinHeight) < listViewHeight;

    if (iconVisible) {
      _iconController.forward();
    }
  }
}