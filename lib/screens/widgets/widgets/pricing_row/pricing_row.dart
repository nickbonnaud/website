import 'package:flutter/material.dart';

import 'widgets/info_column.dart';
import 'widgets/title_column.dart';

class PricingRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const PricingRow({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xfff5f5f3)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: TitleColumn(businessListViewKey: _businessListViewKey, scrollController: _scrollController),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: InfoColumn(businessListViewKey: _businessListViewKey, scrollController: _scrollController)
              ),
            ]
          )
        ),
      ),
    );
  }
}