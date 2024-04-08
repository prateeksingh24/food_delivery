import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:smart_delivery/view/screens/home_screen.dart';
import 'package:smart_delivery/view/screens/order_screen.dart';
import 'package:smart_delivery/view/screens/profile.dart';
import 'package:smart_delivery/view/screens/search_screen.dart';

import '../Controller/widgets/utils/AppColor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const OrderScreen(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: AppColors.kmain2,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: AppColors.kmain2,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_bag),
            title: const Text("Order"),
            selectedColor: AppColors.kmain2,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_2),
            title: const Text("Profile"),
            selectedColor: AppColors.kmain2,
          ),],

      ),
      body: _screens[_currentIndex],
    );
  }
}
