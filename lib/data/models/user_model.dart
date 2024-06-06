class UserModel {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? sId;
  String? updatedOn;
  String? createdOn;

  UserModel(
      {this.fullName,
      this.email,
      this.phoneNumber,
      this.address,
      this.sId,
      this.updatedOn,
      this.createdOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    sId = json['_id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['_id'] = this.sId;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
