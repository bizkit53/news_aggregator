// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_aggregator/constans/spacing.dart';

class CustomWideButton extends StatelessWidget {
  /// Constructor
  const CustomWideButton({
    super.key,
    required this.text,
    this.function,
  });

  final String text;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBottom15,
      child: SizedBox(
        height: 56.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: function,
          child: Text(text),
        ),
      ),
    );
  }
}
