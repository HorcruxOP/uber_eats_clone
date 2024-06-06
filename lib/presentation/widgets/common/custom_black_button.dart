import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class CustomBlackButton extends StatelessWidget {
  const CustomBlackButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: const ContinuousRectangleBorder(),
        ),
        onPressed: onPressed,
        child: CustomText(
          text: text,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
