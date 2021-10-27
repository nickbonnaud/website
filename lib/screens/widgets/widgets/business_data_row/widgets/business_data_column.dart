import 'package:flutter/material.dart';
import 'package:website/resources/helpers/column_spacer.dart';

class BusinessDataColumn extends StatefulWidget {
  final AnimatedIconData _animatedIcon;
  final String _title;
  final String _subtitle;
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const BusinessDataColumn({
    required AnimatedIconData animatedIcon,
    required String title,
    required String subTitle,
    required GlobalKey businessListViewKey,
    required ScrollController scrollController
  })
    : _animatedIcon = animatedIcon,
      _title = title,
      _subtitle = subTitle,
      _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;

  @override
  State<BusinessDataColumn> createState() => _BusinessDataColumnState();
}

class _BusinessDataColumnState extends State<BusinessDataColumn> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _iconGlobalKey = GlobalKey();
  
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    widget._scrollController.addListener(_updateIconEnterView);
  }
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * (366 / 1366);
    final double height = MediaQuery.of(context).size.height * (255 / 768);

    return SizedBox(
      width: width,
      child: ColumnSpacer(
        spacer: const SizedBox(height: 16.0),
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 20.0)],
              color: Colors.white,
            ),
            child: AnimatedIcon(
              key: _iconGlobalKey,
              size: width,
              icon: widget._animatedIcon,
              progress: _iconController
            ),
            height: height,
            width: width / 2,
            padding: const EdgeInsets.all(40),
          ),
          Text(
            widget._title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget._subtitle,
              style: const TextStyle(
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ]
      ),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _updateIconEnterView() {
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