import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_eats_clone/logic/cubits/restaurant_cubit/restaurant_cubit.dart';
import 'package:uber_eats_clone/logic/cubits/restaurant_cubit/restaurant_state.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_icon_button.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';
import 'package:uber_eats_clone/presentation/widgets/features/home_screen/restaurant_listview.dart';

class DineInScreen extends StatelessWidget {
  const DineInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: "Now • New Delhi, Delhi ▾",
              fontSize: 20,
            ),
            GapWidget(
              horizontal: true,
              size: 70,
            ),
            CustomIconButton(
              iconName: "assets/icons/ic_filter.png",
            ),
            GapWidget(
              horizontal: true,
              size: -10,
            )
          ],
        ),
        BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoadingState && state.restaurants.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RestaurantErrorState && state.restaurants.isEmpty) {
              return Center(
                  child: CustomText(
                text: state.message.toString(),
              ));
            }
            return RestaurantListView(
              inputList: state.restaurants,
              physics: const NeverScrollableScrollPhysics(),
            );
          },
        ),
      ],
    );
  }
}
