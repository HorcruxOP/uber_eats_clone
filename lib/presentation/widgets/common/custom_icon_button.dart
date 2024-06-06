import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, this.onTap, required this.iconName});

  final Function()? onTap;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(iconName),
    );
  }
}
