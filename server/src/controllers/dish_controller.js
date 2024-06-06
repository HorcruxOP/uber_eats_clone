const DishModel = require("../models/dishes_model");
const mongoose = require('mongoose');

const DishController = {
  createDish: async function (req, res) {
    try {
      const dishData = req.body;
      console.log("Received dish data:", dishData);
      const newDish = new DishModel(dishData);
      await newDish.save();
      console.log("New dish data:", newDish);
      return res.json({
        success: true,
        data: newDish,
        message: "Dish created",
      });
    } catch (error) {
      console.log(error);
      return res.json({ success: false, message: error });
    }
  },
  fetchAllDish: async function (req, res) {
    try {
      const restaurantId = req.params.restaurantId.trim();
      
      const dishes = await DishModel.find({ restaurantId: restaurantId });
      
      
      return res.json({
        success: true,
        data: dishes,
        message: "Dishes fetched",
      });
    } catch (error) {
      console.log(error);
      return res.json({ success: false, message: error });
    }
  },
};

module.exports = DishController;
