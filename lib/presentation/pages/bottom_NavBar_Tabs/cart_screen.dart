import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:uber_eats_clone/logic/provider/cart_provider.dart';
import 'package:uber_eats_clone/logic/services/razorpay.dart';
import 'package:uber_eats_clone/presentation/pages/home.dart';
import 'package:uber_eats_clone/presentation/pages/others/empty_cart_screen.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_black_button.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String promotion = "200";
  String deliveryFee = "100";
  String tax = "50";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CartProvider>(context, listen: false).fetchcartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Cart Details",
          fontSize: 30,
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.cart.isEmpty || value.cart["dishName"] == null) {
            return const EmptyCartScreen();
          } else {
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                const ListTile(
                  leading: Icon(
                    Iconsax.location5,
                    color: Colors.black,
                  ),
                  title: CustomText(
                    text: "Current Address",
                    fontSize: 17,
                  ),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(
                    Iconsax.truck_fast,
                    color: Colors.black,
                  ),
                  title: CustomText(
                    text: "Delivery Time",
                    fontSize: 17,
                  ),
                  trailing: CustomText(
                    text: "15-30 min(s)",
                    fontSize: 15,
                  ),
                ),
                const GapWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Your Items",
                      fontSize: 17,
                    ),
                    ListTile(
                      leading:
                          CustomText(text: value.cart["quantity"].toString()),
                      title: CustomText(text: value.cart["dishName"]),
                      subtitle: CustomText(text: value.cart["dishDesc"]),
                      trailing: CustomText(
                        text: "₹${value.cart["price"]}",
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
                const GapWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Subtotal"),
                    CustomText(text: "₹${value.cart["price"]}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Promotion"),
                    CustomText(text: "- ₹$promotion"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Delivery fee"),
                    CustomText(text: "₹$deliveryFee"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Tax & other charges"),
                    CustomText(text: "₹$tax"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Total"),
                    CustomText(text: "₹${value.cart["total"]}"),
                  ],
                ),
                const GapWidget(),
                CustomBlackButton(
                  text: "Proceed to payment",
                  onPressed: () async {
                    User? user = await FirebaseAuth.instance.currentUser;
                    print(value.cart["total"].toString());

                    await RazorpayServices.checkoutOrder(
                      value.cart["dishName"],
                      user!.phoneNumber,
                      value.cart["total"] * 100,
                      onSuccess: (response) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: CustomText(text: "Payment Succesfull"),
                          ),
                        );
                        Timer(
                          const Duration(seconds: 2),
                          () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Provider.of<CartProvider>(context, listen: false)
                                .emptyCart();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            );
                          },
                        );
                      },
                      onFailure: (response) {
                        log("Payment Failed");
                      },
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
