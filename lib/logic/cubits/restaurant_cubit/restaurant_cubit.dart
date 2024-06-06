import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/logic/cubits/restaurant_cubit/restaurant_state.dart';
import 'package:uber_eats_clone/data/models/restaurant_model.dart';
import 'package:uber_eats_clone/data/repositories/restaurant_repository.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(RestaurantInitialState()) {
    _initialize();
  }

  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  void _initialize() async {
    emit(RestaurantLoadingState(state.restaurants));
    try {
      List<RestaurantModel> restaurants =
          await _restaurantRepository.fetchRestaurant();
      emit(RestaurantLoadedState(restaurants));
    } catch (e) {
      emit(RestaurantErrorState(state.restaurants, e.toString()));
    }
  }
}
