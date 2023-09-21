import 'dart:developer';

import 'package:ecom_app/core/routes.dart';
import 'package:ecom_app/core/ui.dart';
import 'package:ecom_app/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecom_app/logic/cubit/products_cubit/products_cubit.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_cubit.dart';

import 'package:ecom_app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'logic/cubit/cart_cubit/cart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(
            create: (context) =>
                CartCubit(BlocProvider.of<UserCubit>(context))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.defaultTheme,
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");

    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc:$change");

    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("transition in $bloc:$transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("closed:$bloc");
    super.onClose(bloc);
  }
}
