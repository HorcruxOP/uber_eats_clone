import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class SmallBox extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const SmallBox({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 6, right: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(7),
              ),
              width: 92,
              height: 95,
              child: Center(
                child: Image.asset("assets/icons/ic_filter.png"),
              ),
            ),
            CustomText(
              text: text,
              fontSize: 15,
            )
          ],
        ),
      ),
    );
  }
}
