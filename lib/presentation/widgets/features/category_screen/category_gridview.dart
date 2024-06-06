import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class CategoryGridview extends StatelessWidget {
  const CategoryGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: [
                Expanded(
                  child: Container(
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
                ),
                const CustomText(
                  text: "text",
                  fontSize: 15,
                )
              ],
            ),
          );
        },
      );
  }
}