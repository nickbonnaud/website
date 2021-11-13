import 'package:flutter/material.dart';

import 'widgets/signup_now_button.dart';
import 'widgets/signup_now_text.dart';

class SignupNowRow extends StatelessWidget {
  final GlobalKey _businessListViewKey;
  final ScrollController _scrollController;

  const SignupNowRow({required GlobalKey businessListViewKey, required ScrollController scrollController})
    : _businessListViewKey = businessListViewKey,
      _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child:  SignupNowButton(businessListViewKey: _businessListViewKey, scrollController: _scrollController)
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: SignupNowText(businessListViewKey: _businessListViewKey, scrollController: _scrollController),
            ),
          ],
        ),
      ),
    );
  }
}