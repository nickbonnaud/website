import 'package:flutter/material.dart';

class VisibilityFinder {
  final GlobalKey _parentKey;
  final GlobalKey _childKey;
  final double _enterAnimationMinHeight;

  const VisibilityFinder({required GlobalKey parentKey, required GlobalKey childKey, double enterAnimationMinHeight = 100})
    : _parentKey = parentKey,
      _childKey = childKey,
      _enterAnimationMinHeight = enterAnimationMinHeight;

  bool isVisible({initialOffset = 0}) {
    RenderObject? parentObject = _parentKey.currentContext?.findRenderObject();
    RenderObject? childObject = _childKey.currentContext?.findRenderObject();

    if (parentObject == null || childObject == null) return false;

    final double parentViewHeight = parentObject.paintBounds.height;
    final double childObjectTop = childObject.getTransformTo(parentObject).getTranslation().y;

    return (childObjectTop + _enterAnimationMinHeight + initialOffset) < parentViewHeight;
  }
}