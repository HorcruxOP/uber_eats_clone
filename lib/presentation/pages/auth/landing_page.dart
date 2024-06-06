import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_state.dart';
import 'package:uber_eats_clone/core/custom_text.dart';
import 'package:uber_eats_clone/presentation/pages/auth/otp_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String completePhoneNumber = "";

  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Image.asset(
                "assets/images/landingpage.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Use your uber account to get started",
                    style: CustomTextStyle.mediumText.copyWith(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is UserCodeSentState) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    number: completePhoneNumber,
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is UserLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return IntlPhoneField(
                              controller: phoneController,
                              initialCountryCode: "IN",
                              flagsButtonPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              dropdownIconPosition: IconPosition.trailing,
                              disableLengthCheck: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter your phone number",
                              ),
                              onChanged: (value) async {
                                completePhoneNumber = value.completeNumber;
                                if (value.number.length == 10) {
                                  BlocProvider.of<UserCubit>(context)
                                      .sendOtp(value.completeNumber);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
