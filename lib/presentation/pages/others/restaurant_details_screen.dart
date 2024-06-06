import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/logic/cubits/product_cubit/product_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/product_cubit/product_state.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';
import 'package:uber_eats_clone/presentation/widgets/features/product_list.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String restaurantName, location, restaurantId;
  const RestaurantDetailsScreen(
      {super.key,
      required this.restaurantName,
      required this.location,
      required this.restaurantId});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductCubit>(context)
        .fetchProductList(widget.restaurantId);
  }

  double minChildSize = 0.68;
  double initialChildSize = 0.68;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                child: Image.asset(
                  "assets/images/restaurant_cover.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                child: Image.asset(
                  "assets/images/restaurant_cover.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            minChildSize: minChildSize,
            maxChildSize: 1,
            initialChildSize: initialChildSize,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    children: [
                      const GapWidget(size: 20),
                      CustomText(
                        text: widget.restaurantName,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: "(${widget.location})",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      const CustomText(text: "ratings"),
                      const CustomText(text: "time"),
                      const GapWidget(),
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ProductErrorState) {
                            return Center(
                              child: Text(state.message.toString()),
                            );
                          } else {
                            return ProductList(products: state.products);
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
