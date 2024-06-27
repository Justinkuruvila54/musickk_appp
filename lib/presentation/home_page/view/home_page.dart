import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muzik/core/constants/color.dart';
import 'package:muzik/presentation/favourite_page/view/favourite_page.dart';
import 'package:muzik/presentation/hero_widget_page/view/hero_widget_screen.dart';
import 'package:muzik/presentation/home_page/controller/song_data_controller.dart';
import 'package:muzik/presentation/home_page/controller/song_player_controller.dart';
import 'package:muzik/presentation/home_page/view/search.dart';
import 'package:muzik/presentation/home_page/view/song_page.dart';
import 'package:muzik/presentation/home_page/view/widgets/custom_listed_page.dart';
import 'package:muzik/presentation/setting_screen/view/privacy_policy_screen.dart';
import 'package:muzik/presentation/setting_screen/view/setting_screen.dart';
import 'package:muzik/presentation/setting_screen/view/terms_and_condition_screen.dart';
// Import the new search screen

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with WidgetsBindingObserver {
  final SongDataController songDataController = Get.put(SongDataController());
  final SongPlayerController songPlayerController =
      Get.put(SongPlayerController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Handle any state restoration here if needed
      print("App resumed");
    }
  }

  void _onSearchSubmitted(String query) {
    Get.to(() => SearchScreen(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            backgroundColor: Color.fromARGB(255, 44, 2, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen(),
                          ));
                    },
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditionScreen(),
                          ));
                    },
                    child: Text(
                      "Terms and Conditions",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            )),
        appBar: AppBar(
          backgroundColor: ColorConstants.customGrey,
          title: Center(child: Text("Muzik")),
        ),
        floatingActionButton:
            songPlayerController.isPlaying.value ? HeroWidgetScreen() : null,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/favourate_music.jpg"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100.withOpacity(0.1),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: searchController,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 88, 81, 81)),
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: const Color.fromARGB(255, 226, 222, 222),
                          filled: true,
                          hoverColor: Colors.white,
                          prefixIcon: Icon(Icons.search),
                          hintText: "search songs",
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 101, 95, 95)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5))),
                      onFieldSubmitted: _onSearchSubmitted,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Favourite songs",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(73, 43, 4, 4),
                      ),
                      child: Center(
                        child: Obx(() => CarouselSlider(
                              options: CarouselOptions(
                                height: 100,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: songDataController.songList.value
                                  .map((e) => CustomListedPage(
                                        songName: e.title,
                                        artist: e.artist!,
                                        onPressed: () {
                                          songPlayerController
                                              .playLocalAudio(e);
                                          songDataController.currentIndex(e.id);
                                          Get.to(
                                              () => SongPageScreen(details: e));
                                        },
                                        image: e.id,
                                        images: '',
                                      ))
                                  .toList(),
                            )),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              songDataController.isDeviceSongs.value = true;
                            },
                            child: Text(
                              "Device Songs",
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: songDataController
                                              .isDeviceSongs.value
                                          ? Color.fromARGB(255, 155, 125, 128)
                                          : ColorConstants.customWhite)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Obx(() => songDataController
                                  .isDeviceSongs.value
                              ? SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: songDataController.songList.value
                                        .map((e) => CustomListedPage(
                                              songName: e.title,
                                              artist: e.artist!,
                                              onPressed: () {
                                                songPlayerController
                                                    .playLocalAudio(e);
                                                songDataController
                                                    .currentIndex(e.id);
                                                Get.to(() =>
                                                    SongPageScreen(details: e));
                                              },
                                              image: e.id,
                                              images: '',
                                            ))
                                        .toList(),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: FavouriteScreen(),
                                      )
                                    ],
                                  ),
                                )),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
