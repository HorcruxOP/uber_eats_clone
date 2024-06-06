import 'package:flutter/material.dart';
import 'package:uber_eats_clone/presentation/pages/bottom_NavBar_Tabs/account_screen.dart';
import 'package:uber_eats_clone/presentation/pages/bottom_NavBar_Tabs/browse_screen.dart';
import 'package:uber_eats_clone/presentation/pages/bottom_NavBar_Tabs/cart_screen.dart';
import 'package:uber_eats_clone/presentation/pages/bottom_NavBar_Tabs/grocery_screen.dart';
import 'package:uber_eats_clone/presentation/pages/bottom_NavBar_Tabs/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> navBarScreens = [
    const HomeScreen(),
    const BrowseScreen(),
    const GroceryScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navBarScreens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Grocery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Baskets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
