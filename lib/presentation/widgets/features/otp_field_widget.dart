import 'package:flutter/material.dart';
import 'package:uber_eats_clone/core/custom_text.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
  }

  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
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
                    style: CustomTextStyle.mediumText,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        _focusNodes[index + 1].requestFocus();
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
  }
}
