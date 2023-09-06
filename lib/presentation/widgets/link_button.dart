import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const LinkButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      
        padding: EdgeInsets.zero, child: Text(text), onPressed: onPressed);
  }
}
