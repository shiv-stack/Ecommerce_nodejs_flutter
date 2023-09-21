import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/core/ui.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecom_app/presentation/screens/home/category_screen.dart';
import 'package:ecom_app/presentation/screens/home/profile_screen.dart';
import 'package:ecom_app/presentation/screens/home/userfeed_screen.dart';
import 'package:ecom_app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String imurl =
      "https://imgs.search.brave.com/WUvZYF5DKB7VBPEYKVXoXO2NlX0rkZiwCf6VSDZLvPQ/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9hcG5h/YmF6YXJhcHAuY29t/L3dwLWNvbnRlbnQv/dXBsb2Fkcy8yMDIw/LzEyL0FwbmFCYXph/ci1sb2dvLnBuZw";
  List<Widget> screens = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(
      listener: (context, state) {
        if(state is UserLoggedOutState){
          Navigator.pushReplacementNamed(context,SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: CachedNetworkImage(
                imageUrl: imurl,
              )),
          title: Center(
            child: const Text(
              "Apna Bazaar",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }, icon: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              return Badge(
                showBadge: (state is CartLoadingState)? false :true,
               
                
                  badgeContent: Text("${state.items.length}"),
                  child: Icon(CupertinoIcons.cart_fill));
            }))
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Category"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ]),
      ),
    );
  }
}
