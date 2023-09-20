import 'package:ecom_app/data/models/category/category_model.dart';
import 'package:ecom_app/data/models/products/products_model.dart';
import 'package:ecom_app/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecom_app/presentation/screens/auth/login_screen.dart';
import 'package:ecom_app/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecom_app/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecom_app/presentation/screens/auth/signup_screen.dart';
import 'package:ecom_app/presentation/screens/errorscreen/error_screen.dart';
import 'package:ecom_app/presentation/screens/home/category_screen.dart';
import 'package:ecom_app/presentation/screens/home/home_screen.dart';
import 'package:ecom_app/presentation/screens/products/category_product.dart';
import 'package:ecom_app/presentation/screens/products/products_details_screen.dart';
import 'package:ecom_app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/cart/cart_screen.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
            builder: ((context) => ChangeNotifierProvider(
                create: (context) => SignUpProvider(context),
                child: const SignUpScreen())));
      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case ErrorScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const ErrorScreen());
      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());
      case categoryProduct.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      CategoryProductCubit(settings.arguments as CategoryModel),
                  child: const categoryProduct(),
                ));

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productModel: settings.arguments as ProductModel,
                ));
      default:
        return null; //404 error
    }
  }
}
