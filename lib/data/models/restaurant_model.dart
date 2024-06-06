class RestaurantModel {
  String? restaurantName;
  String? email;
  String? phoneNumber;
  String? address;
  String? location;
  String? deliveryFee;
  String? deliveryTime;
  String? pickUpTime;
  String? sId;
  String? updatedOn;
  String? createdOn;

  RestaurantModel(
      {this.restaurantName,
      this.email,
      this.phoneNumber,
      this.address,
      this.location,
      this.deliveryFee,
      this.deliveryTime,
      this.pickUpTime,
      this.sId,
      this.updatedOn,
      this.createdOn});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    restaurantName = json['restaurantName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    location = json['location'];
    deliveryFee = json['deliveryFee'];
    deliveryTime = json['deliveryTime'];
    pickUpTime = json['pickUpTime'];
    sId = json['_id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantName'] = this.restaurantName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['location'] = this.location;
    data['deliveryFee'] = this.deliveryFee;
    data['deliveryTime'] = this.deliveryTime;
    data['pickUpTime'] = this.pickUpTime;
    data['_id'] = this.sId;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
