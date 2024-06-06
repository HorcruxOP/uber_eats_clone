import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({super.key, this.onTap, required this.icon});
  final Function()? onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            icon,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
