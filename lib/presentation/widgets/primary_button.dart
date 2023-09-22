import 'package:ecom_app/core/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  const PrimaryButton(
      {super.key, required this.text, this.onPressed, this.color, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
          color: color ?? AppColors.accent,
          child: Text(text),
          onPressed: onPressed),
    );
  }
}
