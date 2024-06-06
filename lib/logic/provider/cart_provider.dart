import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Map<String, dynamic> cart = {
    "dishName": "",
    "dishDesc": "",
    "price": "",
    "quantity": "",
    "total": "",
    "customization": "",
  };

  void addToCart(String dishName, String? dishDesc, double? price, int quantity,
      double? total, List<String>? customization) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    calculateTotal();

    cart = {
      "dishName": dishName,
      "dishDesc": dishDesc,
      "price": price,
      "quantity": quantity,
      "total": total,
      "customization": customization,
    };

    await preferences.setString("dishName", dishName);
    await preferences.setInt("quantity", quantity);
    if (dishDesc != null) await preferences.setString("dishDesc", dishDesc);
    if (price != null) {
      await preferences.setDouble("price", price);
    }
    if (total != null) await preferences.setDouble("total", total);
    if (customization != null) {
      await preferences.setStringList("customization", customization);
    }

    print(cart);
    notifyListeners();
  }

  void fetchcartList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? dishName = preferences.getString("dishName");
    final int? quantity = preferences.getInt("quantity");
    final String? dishDesc = preferences.getString("dishDesc");
    final double? price = preferences.getDouble("price");
    final double? total = preferences.getDouble("total");
    final List<String>? customization =
        preferences.getStringList("customization");

    calculateTotal();

    cart = {
      "dishName": dishName,
      "quantity": quantity,
      "dishDesc": dishDesc,
      "price": price,
      "total": total,
      "customization": customization,
    };

    print(cart);
    notifyListeners();
  }

  String promotion = "200";
  String deliveryFee = "100";
  String tax = "50";

  void calculateTotal() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int? quantity = preferences.getInt("quantity");
    final double? price = preferences.getDouble("price");

    if (price != null && quantity != null) {
      var newTotal = (price * quantity) -
          double.parse(promotion) +
          double.parse(deliveryFee) +
          double.parse(tax);
      cart.update("total", (value) => newTotal);
      notifyListeners();
    }
  }

  void emptyCart() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    cart = {
      "dishName": "",
      "dishDesc": "",
      "price": "",
      "quantity": "",
      "total": "",
      "customization": "",
    };
  }
}
