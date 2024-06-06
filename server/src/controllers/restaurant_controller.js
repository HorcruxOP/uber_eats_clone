const RestaurantModel = require("../models/restaurant_model");

const RestaurantController = {
  createRestaurant: async function (req, res) {
    try {
      const restaurantData = req.body;

      const restaurantLocation = await RestaurantModel.findOne({
        location: restaurantData.location,
        email: restaurantData.email,
      });
      if (restaurantLocation) {
        return res.json({
          success: false,
          message: "Restaurant already exists",
        });
      }

      const newRestaurant = new RestaurantModel(restaurantData);
      await newRestaurant.save();
      return res.json({
        success: true,
        data: newRestaurant,
        message: "Restaurant created",
      });
    } catch (error) {
      return res.json({ success: false, message: error });
    }
  },
  fetchRestaurantList: async function (req, res) {
    try {
      const restaurants = await RestaurantModel.find();

      return res.json({
        success: true,
        data: restaurants,
        message: "Restaurant list",
      });
    } catch (error) {
      return res.json({ success: false, message: error });
    }
  },
};

module.exports = RestaurantController;
