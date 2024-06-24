// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, invalid_use_of_protected_member

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:musizk_app/core/constants/color.dart';
import 'package:musizk_app/presentation/favourite_page/view/favourite_page.dart';
import 'package:musizk_app/presentation/hero_widget_page/view/hero_widget_screen.dart';

import 'package:musizk_app/presentation/home_page/controller/song_data_controller.dart';
import 'package:musizk_app/presentation/home_page/controller/song_player_controller.dart';
import 'package:musizk_app/presentation/home_page/view/song_page.dart';
import 'package:musizk_app/presentation/home_page/view/widgets/custom_listed_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  SongDataController songDataController = Get.put(SongDataController());
  SongPlayerController songPlayerController = Get.put(SongPlayerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.customGrey,
          leading: Icon(Icons.library_music_rounded),
          title: Center(child: Text("Muzik")),
        ),
        floatingActionButton:
            songPlayerController.isPlaying.value ? HeroWidgetScreen() : null,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/favourate_music.jpg"),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100.withOpacity(0.1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ListTile(
                        //     leading: CircleAvatar(
                        //   radius: 20,
                        // )),

                        SizedBox(
                          height: 10,
                        ),

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
                                              ? Color.fromARGB(
                                                  255, 155, 125, 128)
                                              : ColorConstants.customWhite)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child:
                                Obx(() => songDataController.isDeviceSongs.value
                                    ? Column(
                                        children: songDataController
                                            .songList.value
                                            .map((e) => CustomListedPage(
                                                  songName: e.title,
                                                  artist: e.artist!,
                                                  onPressed: () {
                                                    songPlayerController
                                                        .playLocalAudio(e);

                                                    songDataController
                                                        .currentIndex(e.id);

                                                    Get.to(() => SongPageScreen(
                                                          details: e,
                                                        ));
                                                  },
                                                ))
                                            .toList(),
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                              height: MediaQuery.sizeOf(context)
                                                  .height,
                                              child: FavouriteScreen())
                                        ],
                                      )))
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
