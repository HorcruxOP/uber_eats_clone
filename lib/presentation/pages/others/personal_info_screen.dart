import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/presentation/pages/home.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_state.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';
import 'package:uber_eats_clone/presentation/widgets/features/personal_info_textfield.dart';

class PersonalInfoScreen extends StatefulWidget {
  final String phoneNumber;
  const PersonalInfoScreen({super.key, required this.phoneNumber});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Personal Info",
          fontSize: 35,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            PersonalInfoTextfield(
              text: "Name*",
              labelText: "Enter your name",
              autofocus: true,
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name cannot be empty";
                }
                return null;
              },
            ),
            const GapWidget(size: 10),
            PersonalInfoTextfield(
              text: "Email*",
              labelText: "Enter your email",
              controller: emailController,
              autofocus: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email cannot be empty";
                } else if (!(value.toString().contains("@"))) {
                  return "Enter a valid email address";
                }
                return null;
              },
            ),
            const GapWidget(size: 10),
            PersonalInfoTextfield(
              text: "Address",
              labelText: "Enter your address",
              controller: addressController,
              autofocus: false,
            ),
            const GapWidget(size: 20),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                log('Current state: $state');
                if (state is UserDetailsCreatedState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                  FocusScope.of(context).unfocus();
                } else if (state is UserErrorState) {
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: CustomText(text: state.message)));
                  }
                }
              },
              builder: (context, state) {
                if (state is UserLoadingState) {
                  log('Current state: $state');
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<UserCubit>(context).createAccount(
                            email: emailController.text.trim(),
                            fullName: nameController.text.trim(),
                            phoneNumber: widget.phoneNumber,
                            address: addressController.text,
                          );
                          print(nameController.text);
                          print(emailController.text);
                          print(addressController.text);
                        }
                      },
                      child: const CustomText(
                        text: "Submit",
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
