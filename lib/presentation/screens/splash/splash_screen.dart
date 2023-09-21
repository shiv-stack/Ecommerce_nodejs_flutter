import 'dart:async';
import 'dart:developer';

import 'package:ecom_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecom_app/presentation/screens/auth/login_screen.dart';
import 'package:ecom_app/presentation/screens/errorscreen/error_screen.dart';
import 'package:ecom_app/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goTONextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;

    if (userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (UserState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else if (userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
    } else {
      log("erorr -----aara");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      goTONextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        goTONextScreen();
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
