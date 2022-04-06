import 'package:flutter/material.dart';

class VisibilityFinder {
  final double _enterAnimationMinHeight;

  const VisibilityFinder({double enterAnimationMinHeight = 100})
    : _enterAnimationMinHeight = enterAnimationMinHeight;

  bool isVisible({required GlobalKey parentKey, required GlobalKey childKey, initialOffset = 0}) {
    RenderObject? parentObject = parentKey.currentContext?.findRenderObject();
    RenderObject? childObject = childKey.currentContext?.findRenderObject();

    if (parentObject == null || childObject == null) return false;

    final double parentViewHeight = parentObject.paintBounds.height;
    final double childObjectTop = childObject.getTransformTo(parentObject).getTranslation().y;

    return (childObjectTop + _enterAnimationMinHeight + initialOffset) < parentViewHeight;
  }
}