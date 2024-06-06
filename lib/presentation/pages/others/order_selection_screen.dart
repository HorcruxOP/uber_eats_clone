import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_eats_clone/data/models/product_model.dart';
import 'package:uber_eats_clone/logic/provider/cart_provider.dart';
import 'package:uber_eats_clone/presentation/pages/bottom_NavBar_Tabs/cart_screen.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_black_button.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';
import 'package:uber_eats_clone/presentation/widgets/features/order_customization_list.dart';
import 'package:uber_eats_clone/presentation/widgets/features/quantity_button.dart';

class OrderSelectionScreen extends StatefulWidget {
  final ProductModel productModel;
  const OrderSelectionScreen({super.key, required this.productModel});

  @override
  State<OrderSelectionScreen> createState() => _OrderSelectionScreenState();
}

class _OrderSelectionScreenState extends State<OrderSelectionScreen> {
  int quantity = 1;
  dynamic selectedValue;
  List<String> finalCustomizationList = [];
  List headingCustomizationList = ["Choose your sauce", "Choose your size"];

  @override
  void initState() {
    super.initState();
    finalCustomizationList =
        List.generate(widget.productModel.customizations.length, (index) {
      return widget.productModel.customizations[index].isNotEmpty
          ? widget.productModel.customizations[index][0]
          : '';
    });
  }

  void handleValueChanged(dynamic value, int index) {
    setState(() {
      selectedValue = value;
      finalCustomizationList[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.productModel.dishName,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "₹${widget.productModel.price!}",
                  fontSize: 25,
                ),
                Text(
                  widget.productModel.ingredients!,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const GapWidget(),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.productModel.customizations.length,
            itemBuilder: (context, index) {
              final item = widget.productModel.customizations[index];
              return OrderCustomizationList(
                titleName: headingCustomizationList[index],
                listItems: item,
                isRequired: true,
                onValueChanged: (value) {
                  handleValueChanged(value, index);
                },
              );
            },
          ),
          const GapWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuantityButton(
                icon: "-",
                onTap: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
              ),
              const GapWidget(horizontal: true),
              CustomText(
                text: quantity.toString(),
                fontSize: 25,
              ),
              const GapWidget(horizontal: true),
              QuantityButton(
                icon: "+",
                onTap: () {
                  if (quantity < 20) {
                    setState(() {
                      quantity++;
                    });
                  }
                },
              )
            ],
          ),
          const GapWidget(),
          const Divider(),
          const GapWidget(),
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return CustomBlackButton(
                text: "Add $quantity to basket",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                  print(widget.productModel.dishName);
                  print(widget.productModel.ingredients);
                  print(widget.productModel.price);
                  Provider.of<CartProvider>(context, listen: false).addToCart(
                    widget.productModel.dishName,
                    widget.productModel.ingredients,
                    double.parse(widget.productModel.price!),
                    quantity,
                    0,
                    finalCustomizationList,
                  );
                },
              );
            },
          ),
          const GapWidget(),
        ],
      ),
    );
  }
}
