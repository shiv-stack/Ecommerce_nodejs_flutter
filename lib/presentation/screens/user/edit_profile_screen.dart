import 'dart:async';
import 'dart:developer';

import 'package:ecom_app/core/ui.dart';
import 'package:ecom_app/data/models/user/user_model.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecom_app/presentation/widgets/gap_space.dart';
import 'package:ecom_app/presentation/widgets/primary_button.dart';
import 'package:ecom_app/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is UserLoggedInState) {
          return editProfile(
            state.userModel,
          );
        }

        return const Center(
          child: Text("An error occured"),
        );
      })),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Personal Details",
          style: TextStyles.b1.copyWith(fontWeight: FontWeight.bold),
        ),
        PrimaryTextField(
            onChanged: (value) {
              userModel.fullName = value;
            },
            initialValue: userModel.fullName,
            labelText: 'Full Name'),
        const SizedBoxSpace(),
        PrimaryTextField(
            onChanged: (value) {
              userModel.phoneNumber = value;
            },
            initialValue: userModel.phoneNumber,
            labelText: "Phone Number"),
        const SizedBoxSpace(),
        Text(
          "Address",
          style: TextStyles.b1.copyWith(fontWeight: FontWeight.bold),
        ),
        PrimaryTextField(
          onChanged: (value) {
            userModel.address = value;
          },
          initialValue: userModel.address,
          labelText: "Address",
        ),
        const SizedBoxSpace(),
        PrimaryTextField(
            onChanged: (value) {
              userModel.city = value;
            },
            initialValue: userModel.city,
            labelText: "City"),
        const SizedBoxSpace(),
        PrimaryTextField(
            onChanged: (value) {
              userModel.state = value;
            },
            initialValue: userModel.state,
            labelText: "State"),
        const SizedBoxSpace(),
        PrimaryButton(
            onPressed: () async {
              bool success = await BlocProvider.of<UserCubit>(context)
                  .updateUser(userModel);

              if (success) {
                Navigator.pop(context);
              }
            },
            text: "save")
      ],
    );
  }
}
