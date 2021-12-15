import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class ResultsImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: '/assets/faqs/results.jpg',
        fit: BoxFit.cover,
        height: .8.sh,
      ),
    );
  }
}