import 'package:flutter/material.dart';

class GapWidget extends StatelessWidget {
  const GapWidget({
    super.key,
    this.horizontal = false,
    this.size = 0,
  });
  final bool horizontal;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !horizontal ? 0 : 20 + size,
      height: horizontal ? 0 : 20 + size,
    );
  }
}
