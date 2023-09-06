import 'package:ecom_app/presentation/screens/auth/login_screen.dart';
import 'package:ecom_app/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecom_app/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecom_app/presentation/screens/auth/signup_screen.dart';
import 'package:ecom_app/presentation/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));
      case SignUpScreen.routeName:
        return CupertinoPageRoute(builder: ((context) => ChangeNotifierProvider(create: (context) => SignUpProvider(context),
          child: const SignUpScreen())));
          case HomeScreen.routeName:
        return CupertinoPageRoute(builder: ((context) => const HomeScreen()));

      default:
        return null; //404 error
    }
  }
}