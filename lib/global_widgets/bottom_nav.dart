// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:muzik/core/constants/color.dart';
// import 'package:muzik/presentation/favourite_page/view/favourite_page.dart';
// import 'package:muzik/presentation/home_page/view/home_page.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int indexNum = 0;
//   List pages = [HomePageScreen(), FavouriteScreen()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 30,
//         type: BottomNavigationBarType.fixed,
//         //fixedColor: ColorConstants.customGrey,
//         backgroundColor: ColorConstants.customGrey,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//             // backgroundColor: Colors.green
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: "Favourites",
//             // backgroundColor: Colors.amber
//           ),
//         ],
//         currentIndex: indexNum,
//         onTap: (value) {
//           setState(() {
//             indexNum = value;
//           });
//         },
//         selectedFontSize: 18,
//         selectedItemColor: ColorConstants.customBlack,
//         unselectedFontSize: 15,
//         unselectedItemColor: ColorConstants.customGrey2,
//       ),
//       body: pages[indexNum],
//     );
//   }
// }

