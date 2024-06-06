import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/pages/others/order_selection_screen.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';

class ProductList extends StatelessWidget {
  final List<dynamic> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Most Popular",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSelectionScreen(
                        productModel: product,
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: product.dishName!,
                              fontSize: 15,
                            ),
                            CustomText(
                              text: product.price!,
                            ),
                            Text(
                              product.ingredients!,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        width: 100,
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
