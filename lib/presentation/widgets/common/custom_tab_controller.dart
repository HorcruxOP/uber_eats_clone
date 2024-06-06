import 'package:flutter/material.dart';
import 'package:uber_eats_clone/core/custom_text.dart';

class CustomTabController extends StatelessWidget {
  const CustomTabController({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        controller: tabController,
        padding: const EdgeInsets.symmetric(horizontal: 45),
        labelColor: Colors.white,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: CustomTextStyle.mediumText.copyWith(fontSize: 17),
        unselectedLabelStyle: CustomTextStyle.mediumText.copyWith(fontSize: 17),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        splashFactory: NoSplash.splashFactory,
        tabs: const [
          Tab(
            child: Text("Delivery"),
          ),
          Tab(
            child: Text("Pickup"),
          ),
          Tab(
            child: Text("Dine-in"),
          )
        ],
      ),
    );
  }
}
