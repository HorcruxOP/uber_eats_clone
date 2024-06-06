import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_icon_button.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class BigBox extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const BigBox({
    super.key,
    required this.text, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(
                left: 6,
                right: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 90,
            ),
          ),
          Positioned(
            left: 20,
            bottom: 10,
            child: CustomText(
              text: text,
              fontSize: 20,
            ),
          ),
          const Positioned(
            right: 20,
            top: 10,
            child: CustomIconButton(
              iconName: "assets/icons/ic_filter.png",
            ),
          ),
        ],
      ),
    );
  }
}
