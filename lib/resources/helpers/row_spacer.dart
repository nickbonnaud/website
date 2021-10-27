import 'package:flutter/material.dart';

class RowSpacer extends StatelessWidget {
  final List<Widget> _children;
  final SizedBox _spacer;

  const RowSpacer({required List<Widget> children, SizedBox spacer = const SizedBox(width: 8)})
    : _children = children,
      _spacer = spacer;

  @override
  Widget build(BuildContext context) {
    final List<Widget> spacedChildren = [];

    for (var i = 0; i < _children.length; i++) {
      if (i == 0) {
        spacedChildren.add(_children[i]);
      } else if (i == _children.length - 1) {
        spacedChildren.add(_spacer);
        spacedChildren.add(_children[i]);
      } else {
        spacedChildren.add(_spacer);
        spacedChildren.add(_children[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: spacedChildren,
    );
  }
}