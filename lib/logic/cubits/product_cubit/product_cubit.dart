import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/data/repositories/product_repository.dart';
import 'package:uber_eats_clone/logic/cubits/product_cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState());

  final ProductRepository _productRepository = ProductRepository();

  void fetchProductList(String restaurantId) async {
    try {
      emit(ProductLoadingState(state.products));
      final products = await _productRepository.fetchProductList(restaurantId);
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(e.toString(), state.products));
    }
  }
}
