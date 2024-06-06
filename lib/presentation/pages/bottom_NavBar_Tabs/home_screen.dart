import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/pages/home_screen_tabs/dine_in_screen.dart';
import 'package:uber_eats_clone/presentation/pages/home_screen_tabs/delivery_screen.dart';
import 'package:uber_eats_clone/presentation/pages/home_screen_tabs/pickup_screen.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_tab_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<Widget> tabBarScreens = [
    const DeliveryScreen(),
    const PickupScreen(),
    const DineInScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomTabController(
            tabController: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabBarScreens,
        ),
      ),
    );
  }
}
