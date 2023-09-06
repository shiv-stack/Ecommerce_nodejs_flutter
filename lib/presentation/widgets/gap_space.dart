import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SizedBoxSpace extends StatelessWidget {
  final double size;
  const SizedBoxSpace({super.key,  this.size=0.0});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
              height: 16 + size,
              width: 16 + size,
            );
  }
}