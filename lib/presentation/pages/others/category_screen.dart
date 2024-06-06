import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/features/category_screen/category_gridview.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "All Categories",
          color: Colors.black,
          fontSize: 23,
        ),
        centerTitle: true,
      ),
      body: const CategoryGridview(),
    );
  }
}
