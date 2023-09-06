import 'package:ecom_app/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_space.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
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
                "Create Account",
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
              const SizedBoxSpace(),
              PrimaryTextField(
                controller: provider.cpasswordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "confirm your password ";
                  }
                  if(value.trim()!= provider.passwordController.text.trim()){
                    return "Passwords do not matched";

                  }
                  return null;
                },
                labelText: "confirm Password",
                obscureText: true,
              ),

              const SizedBoxSpace(),
              //login button
              PrimaryButton(
                  onPressed: provider.createAccount,
                  text: (provider.isLoading) ? "..." : "Create Account"),
              const SizedBoxSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an  account",
                    style: TextStyle(fontSize: 16),
                  ),
                  LinkButton(
                    onPressed: () {},
                    text: "LogIn",
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
