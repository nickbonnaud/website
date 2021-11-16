import 'package:flutter/material.dart';
import 'package:website/resources/helpers/column_spacer.dart';
import 'package:website/resources/helpers/row_spacer.dart';

import 'widgets/business_data_column.dart';

class BusinessDataRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;

  const BusinessDataRow({required GlobalKey businessListViewKey})
    : _businessListViewKey = businessListViewKey; 

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.7),
          spreadRadius: 15,
          blurRadius: 5,
          offset: const Offset(0, 3))
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
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
                    businessListViewKey: _businessListViewKey
                  )
                ),
                Expanded(
                  child: BusinessDataColumn(
                    animatedIcon: AnimatedIcons.ellipsis_search,
                    title: "Second Info Icon",
                    subTitle: "Data about the next icon and some more data as well",
                    businessListViewKey: _businessListViewKey
                  )
                ),
                Expanded(
                  child: BusinessDataColumn(
                    animatedIcon: AnimatedIcons.list_view,
                    title: "Last Info Icon",
                    subTitle: "Data about the final icon and blah blah blah",
                    businessListViewKey: _businessListViewKey
                  )
                ),
              ]
            )
          ]
        ),
      ),
    );
  }
}