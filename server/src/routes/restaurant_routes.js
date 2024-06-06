const RestaurantController = require("../controllers/restaurant_controller");

const RestaurantRoutes = require("express").Router();

RestaurantRoutes.post(
  "/createRestaurant",
  RestaurantController.createRestaurant
);
RestaurantRoutes.get(
  "/restaurantList",
  RestaurantController.fetchRestaurantList
);

module.exports = RestaurantRoutes;
