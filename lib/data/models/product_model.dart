class ProductModel {
  ProductModel({
    required this.restaurantId,
    required this.dishName,
    required this.price,
    required this.ingredients,
    required this.image,
    required this.customizations,
    required this.id,
    required this.updatedOn,
    required this.createdOn,
  });

  final String? restaurantId;
  final String dishName;
  final String? price;
  final String? ingredients;
  final String? image;
  final List<List<String>> customizations;
  final String? id;
  final DateTime? updatedOn;
  final DateTime? createdOn;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      restaurantId: json["restaurantId"],
      dishName: json["dishName"],
      price: json["price"],
      ingredients: json["ingredients"],
      image: json["image"],
      customizations: json["customizations"] == null
          ? []
          : List<List<String>>.from(json["customizations"]!.map(
              (x) => x == null ? [] : List<String>.from(x!.map((x) => x)))),
      id: json["_id"],
      updatedOn: DateTime.tryParse(json["updatedOn"] ?? ""),
      createdOn: DateTime.tryParse(json["createdOn"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "restaurantId": restaurantId,
        "dishName": dishName,
        "price": price,
        "ingredients": ingredients,
        "image": image,
        "customizations":
            customizations.map((x) => x.map((x) => x).toList()).toList(),
        "_id": id,
        "updatedOn": updatedOn?.toIso8601String(),
        "createdOn": createdOn?.toIso8601String(),
      };
}
