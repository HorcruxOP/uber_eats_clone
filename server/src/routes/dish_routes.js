const DishController = require("../controllers/dish_controller");

const DishRoutes = require("express").Router();

DishRoutes.post("/createDish", DishController.createDish);
DishRoutes.get("/:restaurantId", DishController.fetchAllDish);

module.exports = DishRoutes;
