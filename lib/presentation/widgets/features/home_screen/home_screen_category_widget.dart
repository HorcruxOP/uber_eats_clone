import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/pages/others/category_screen.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';
import 'package:uber_eats_clone/presentation/widgets/features/home_screen/big_box.dart';
import 'package:uber_eats_clone/presentation/widgets/features/home_screen/small_box.dart';

class HomeScreenCategoryWidget extends StatelessWidget {
  const HomeScreenCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Row(
            children: [
              BigBox(
                text: "Grocery",
              ),
              BigBox(
                text: "Grocery",
              ),
            ],
          ),
          const GapWidget(size: -9),
          Row(
            children: [
              const SmallBox(
                text: 'Convenience',
              ),
              const SmallBox(
                text: 'Alcohol',
              ),
              const SmallBox(
                text: 'Pet Supplies',
              ),
              SmallBox(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CategoryScreen(),
                    ),
                  );
                },
                text: 'More',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
