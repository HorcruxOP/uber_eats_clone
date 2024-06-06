const { Schema, model } = require("mongoose");

const restaurantSchema = new Schema({
  restaurantName: { type: String, required: true},
  email: { type: String, unique: true, required: true},
  phoneNumber: { type: String, unique: true, required: true},
  address: { type: String,required:true},
  location: { type: String, required: true },
  deliveryFee: { type: String, required: true },
  deliveryTime: { type: String, required: true },
  pickUpTime: { type: String, required: true },
  createdOn: { type: Date },
  updatedOn: { type: Date },
});

restaurantSchema.pre("save", function (next) {
  this.updatedOn = new Date();
  this.createdOn = new Date();
  next();
});

const RestaurantModel = model("Restaurant", restaurantSchema);

module.exports = RestaurantModel;
