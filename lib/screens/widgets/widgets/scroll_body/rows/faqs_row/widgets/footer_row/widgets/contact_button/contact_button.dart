import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/resources/helpers/query_param_encoder.dart';

import 'cubit/contact_button_cubit.dart';

class ContactButton extends StatefulWidget {
  
  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> with SingleTickerProviderStateMixin {
  final QueryParamEncoder _queryParamEncoder = QueryParamEncoder();
  
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _mouseEnter(),
      onExit: (_) => _mouseExit(),
      child: TextButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent)
        ),
        onPressed: () => _contactButtonPressed(),
        icon: Lottie.asset(
          "lotties/email.zip",
          controller: _iconController,
          width: _iconDimensions(),
          height: _iconDimensions()
        ),
        label: BlocBuilder<ContactButtonCubit, bool>(
          builder: (context, isFocused) {
            return Text(
              "Contact",
              style: TextStyle(
                fontSize: _textSize(),
                decoration: isFocused ? TextDecoration.underline : TextDecoration.none
              ),
            );
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  double _iconDimensions() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 110.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 90.w;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 70.w;
    }
    return 40.w;
  }

  double _textSize() {
    if (ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
      return 35.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 30.sp;
    } else if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 25.sp;
    }
    return 20.sp;
  }
  
  void _contactButtonPressed() {
    final String encodedParams = _queryParamEncoder.encode(params: {'subject': 'Contact Nova Pay'});
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@novapay.ai',
      query: encodedParams
    );

    launch(emailLaunchUri.toString());
  }

  void _mouseEnter() {
    _playAnimation();
    BlocProvider.of<ContactButtonCubit>(context).hoverStatusChanged(isFocused: true);
  }

  void _mouseExit() {
    BlocProvider.of<ContactButtonCubit>(context).hoverStatusChanged(isFocused: false);
  }

  void _playAnimation() {
    if (_iconController.isAnimating) return;
    _iconController.forward().then((_) =>  _iconController.reset());
  }
}