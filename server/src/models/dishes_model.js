const { Schema, model } = require("mongoose");

const dishSchema = new Schema({
  restaurantId: { type: String, required: true },
  dishName: { type: String, required: true },
  price: { type: String, required: true },
  ingredients: { type: String, required: true },
  image: { type: String, required: true },
  customizations: { type: Array, of: [String], default: {} },
  createdOn: { type: Date },
  updatedOn: { type: Date },
});

dishSchema.pre("save", function (next) {
  this.updatedOn = new Date();
  this.createdOn = new Date();
  next();
});

const DishModel = model("dish", dishSchema);

module.exports = DishModel;
