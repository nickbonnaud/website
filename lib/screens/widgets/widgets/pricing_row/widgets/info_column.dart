import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/resources/helpers/column_spacer.dart';
import 'package:website/screens/bloc/parallax_bloc.dart';

class InfoColumn extends StatefulWidget {
  final GlobalKey _businessListViewKey;

  const InfoColumn({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey;

  @override
  State<InfoColumn> createState() => _InfoColumnState();
}

class _InfoColumnState extends State<InfoColumn> with SingleTickerProviderStateMixin {
  static const double _enterAnimationMinHeight = 100;
  final GlobalKey _infoGlobalKey = GlobalKey();

  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;
  late final Animation<Offset> _enterAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _enterAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero
    ).animate(_curvedAnimation);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParallaxBloc, ParallaxState>(
      listenWhen: (previousState, currentState) => previousState.offset != currentState.offset,
      listener: (context, state) {
        _updateInfoEnteredView();
      },
      child: SlideTransition(
        key: _infoGlobalKey,
        position: _enterAnimation,
        child: ColumnSpacer(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacer: const SizedBox(height: 20),
          children: [
            Row(
              children: const [
                Text(
                  "1%",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "of total sale",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  "5¢",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "per transaction",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  "\$0",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "setup costs",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  "\$0",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "monthly fees",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                )
              ],
            )
          ]
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateInfoEnteredView() {
    if (_animationController.status != AnimationStatus.dismissed) return;

    RenderObject? businessListViewObject = widget._businessListViewKey.currentContext?.findRenderObject();
    RenderObject? iconObject = _infoGlobalKey.currentContext?.findRenderObject();

    if (businessListViewObject == null || iconObject == null) return;

    final double listViewHeight = businessListViewObject.paintBounds.height;
    final double iconObjectTop = iconObject.getTransformTo(businessListViewObject).getTranslation().y;

    final bool iconVisible = (iconObjectTop + _enterAnimationMinHeight) < listViewHeight;

    if (iconVisible) {
      _animationController.forward();
    }
  }
}