import 'package:uber_eats_clone/data/models/restaurant_model.dart';

abstract class RestaurantState {
  final List<RestaurantModel> restaurants;
  RestaurantState(this.restaurants);
}

class RestaurantInitialState extends RestaurantState {
  RestaurantInitialState() : super([]);
}

class RestaurantLoadingState extends RestaurantState {
  RestaurantLoadingState(super.restaurants);
}

class RestaurantLoadedState extends RestaurantState {
  RestaurantLoadedState(super.restaurants);
}

class RestaurantErrorState extends RestaurantState {
  final String message;
  RestaurantErrorState(super.restaurants,this.message);
}
