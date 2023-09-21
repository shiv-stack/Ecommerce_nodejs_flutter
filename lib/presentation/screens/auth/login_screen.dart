import 'package:ecom_app/core/ui.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecom_app/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecom_app/presentation/screens/auth/signup_screen.dart';
import 'package:ecom_app/presentation/screens/home/home_screen.dart';
import 'package:ecom_app/presentation/screens/splash/splash_screen.dart';
import 'package:ecom_app/presentation/widgets/link_button.dart';
import 'package:ecom_app/presentation/widgets/primary_button.dart';
import 'package:ecom_app/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/gap_space.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          // Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("Ecommerce App"),
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.fromLTRB(10, 70, 10, 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: provider.formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  "Log In",
                  style: TextStyles.h2,
                ),

                const SizedBoxSpace(),
                (provider.error != "")
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                PrimaryTextField(
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address required";
                    }

                    if (!EmailValidator.validate(value.trim())) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                  labelText: "Email Address",
                ),
                const SizedBoxSpace(),
                PrimaryTextField(
                  controller: provider.passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  labelText: "Enter Password",
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LinkButton(
                      text: "Forgot Password?",
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBoxSpace(),
                //login button
                PrimaryButton(
                    onPressed: provider.logIn,
                    text: (provider.isLoading) ? "..." : "Log In"),
                const SizedBoxSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account",
                      style: TextStyle(fontSize: 16),
                    ),
                    LinkButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      text: "Signup",
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
