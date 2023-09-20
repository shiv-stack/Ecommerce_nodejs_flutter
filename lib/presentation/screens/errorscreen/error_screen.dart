import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
   static const String routeName  = "error";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Error found")),
    );
  }
}
