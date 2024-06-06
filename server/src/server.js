const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const UserRoutes = require("./routes/user_routes");
const RestaurantRoutes = require("./routes/restaurant_routes");
const DishRoutes = require("./routes/dish_routes");

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

mongoose.connect("mongodb://localhost:27017/uber_eats");

const PORT = 3000;

app.get("/", function (req, res) {
  res.send("Hello world");
});

app.use("/api/user", UserRoutes);
app.use("/api/restaurant", RestaurantRoutes);
app.use("/api/dish", DishRoutes);

app.listen(PORT, function () {
  console.log(`Server started at Port: ${PORT}`);
});
