import 'package:ecom_app/core/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;
  const LinkButton({super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          text,
          style: TextStyle(color: color ?? AppColors.accent),
        ),
        onPressed: onPressed);
  }
}
