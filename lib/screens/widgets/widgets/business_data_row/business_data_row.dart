import 'package:flutter/material.dart';
import 'package:website/resources/helpers/column_spacer.dart';
import 'package:website/resources/helpers/row_spacer.dart';

import 'widgets/business_data_column.dart';

class BusinessDataRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const BusinessDataRow({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController; 

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: ColumnSpacer(
            spacer: const SizedBox(height: 20),
            children: [
               const Text(
                "Nova Pay for you",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              RowSpacer(
                spacer: const SizedBox(width: 50),
                children: [
                   Expanded(
                    child: BusinessDataColumn(
                      animatedIcon: AnimatedIcons.add_event,
                      title: "First Info Icon",
                      subTitle: "Some more data about this first icon.",
                      businessListViewKey: _businessListViewKey,
                      scrollController: _scrollController,
                    )
                  ),
                  Expanded(
                    child: BusinessDataColumn(
                      animatedIcon: AnimatedIcons.ellipsis_search,
                      title: "Second Info Icon",
                      subTitle: "Data about the next icon and some more data as well",
                      businessListViewKey: _businessListViewKey,
                      scrollController: _scrollController,
                    )
                  ),
                  Expanded(
                    child: BusinessDataColumn(
                      animatedIcon: AnimatedIcons.list_view,
                      title: "Last Info Icon",
                      subTitle: "Data about the final icon and blah blah blah",
                      businessListViewKey: _businessListViewKey,
                      scrollController: _scrollController,
                    )
                  ),
                ]
              )
            ]
          ),
        ),
      ),
    );
  }
}