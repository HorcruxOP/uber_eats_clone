const { Schema, model } = require("mongoose");

const userSchema = new Schema({
  fullName: { type: String, required: true, default: "" },
  email: { type: String, unique: true, required: true, default: "" },
  phoneNumber: { type: String, unique: true, default: "" },
  address: { type: String, default: "" },
  createdOn: { type: Date },
  updatedOn: { type: Date },
});

userSchema.pre("save", function (next) {
  this.updatedOn = new Date();
  this.createdOn = new Date();
  next();
});

const UserModel = model("User", userSchema);

module.exports = UserModel;
