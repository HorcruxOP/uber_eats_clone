const UserModel = require("../models/user_model");

const UserController = {
  createAccount: async function (req, res) {
    try {
      const userData = req.body;

      const foundUser = await UserModel.findOne({ email: userData.email });
      if (foundUser) {
        return res.json({ success: false, message: "Email already exists" });
      }

      const newUser = new UserModel(userData);
      await newUser.save();
      return res.json({
        success: true,
        data: newUser,
        message: "User created",
      });
    } catch (error) {
      console.error("Error creating user:", error);
      return res.json({ success: false, message: error });
    }
  },
  checkUserExist: async function (req, res) {
    try {
      const userData = req.body;

      const foundUser = await UserModel.findOne({
        phoneNumber: userData.phoneNumber,
      });
      if (foundUser) {
        return res.json({
          success: true,
          data: foundUser,
          message: "User already exists",
        });
      }
      return res.json({ success: false, message: "User does not exist" });
    } catch (error) {
      console.error("Error creating user:", error);
      return res.json({ success: false, message: error });
    }
  },
};

module.exports = UserController;
