import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/pages/others/restaurant_details_screen.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView(
      {super.key, required this.physics, required this.inputList});
  final ScrollPhysics? physics;
  final List inputList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      shrinkWrap: true,
      itemCount: inputList.length,
      itemBuilder: (BuildContext context, int index) {
        final inputListItem = inputList[index];
        return GestureDetector(
          onTap: () {
            print(inputListItem.sId.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetailsScreen(
                  restaurantId: inputListItem.sId.toString(),
                  restaurantName: inputListItem.restaurantName,
                  location: inputListItem.location,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Image.asset(
                        "assets/images/restaurant_cover.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const GapWidget(size: -15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "${inputListItem.restaurantName}",
                      fontSize: 18,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: const Center(
                        child: CustomText(
                          text: "4.4",
                        ),
                      ),
                    )
                  ],
                ),
                CustomText(
                  text:
                      "\$${inputListItem.deliveryFee} Delivery Fee • ${inputListItem.deliveryTime} min",
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
