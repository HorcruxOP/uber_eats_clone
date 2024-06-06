import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/presentation/pages/home.dart';
import 'package:uber_eats_clone/presentation/pages/others/personal_info_screen.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/user_cubit/user_state.dart';
import 'package:uber_eats_clone/core/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  const OtpScreen({
    super.key,
    required this.number,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  String get otpValue {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _checkUserExist(bool response) {
    if (response == false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalInfoScreen(
            phoneNumber: widget.number,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            top: 80,
          ),
          children: [
            Text(
              "Enter the 6-digit code sent to you at ${widget.number}",
              style: CustomTextStyle.mediumText.copyWith(
                fontSize: 25,
              ),
            ),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) async {
                if (state is UserLoggedInState) {
                  bool response = await BlocProvider.of<UserCubit>(context)
                      .checkUserExist(phoneNumber: widget.number);

                  print("otp response $response");

                  _checkUserExist(response);
                } else if (state is UserErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: CustomText(text: state.message)));
                }
              },
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            color: Colors.grey[300],
                            width: 60,
                            height: 60,
                            child: Center(
                              child: TextFormField(
                                maxLength: 1,
                                autofocus: index == 0,
                                showCursor: false,
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                style: CustomTextStyle.mediumText,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                                onChanged: (value) async {
                                  if (value.isNotEmpty && index < 5) {
                                    _focusNodes[index + 1].requestFocus();
                                  }
                                  if (value.isEmpty && index > 0) {
                                    _focusNodes[index - 1].requestFocus();
                                  }
                                  if (otpValue.length == 6) {
                                    BlocProvider.of<UserCubit>(context)
                                        .verifyOtp(otpValue);

                                    print("verify otp called");
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
