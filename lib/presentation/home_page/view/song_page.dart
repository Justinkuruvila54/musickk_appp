// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:muzik/core/constants/color.dart';
import 'package:muzik/core/constants/texts.dart';
import 'package:muzik/global_widgets/bottom_nav.dart';
import 'package:muzik/presentation/favourite_page/controller/favourites_controller.dart';
import 'package:muzik/presentation/favourite_page/view/favourite_page.dart';
import 'package:muzik/presentation/home_page/controller/song_data_controller.dart';
import 'package:muzik/presentation/home_page/controller/song_player_controller.dart';
import 'package:muzik/presentation/home_page/view/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPageScreen extends StatefulWidget {
  const SongPageScreen({super.key, this.details});

  final SongModel? details;
  @override
  State<SongPageScreen> createState() => _SongPageScreenState();
}

class _SongPageScreenState extends State<SongPageScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  SongPlayerController songPlayerController = Get.put(SongPlayerController());
  SongDataController songDataController = Get.put(SongDataController());

  late AnimationController aniController;
  late LottieComposition lotComposition;

  @override
  void initState() {
    super.initState();
    aniController = AnimationController(vsync: this);
    songPlayerController.isPlaying.listen((isPlaying) {
      if (isPlaying) {
        aniController.forward();
      } else {
        aniController.stop();
      }
    });
  }

  // @override
  // void dispose() {
  //   aniController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/favourate_music.jpg"),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      filterQuality: FilterQuality.high,
                      'assets/images/songlogo.json',
                      fit: BoxFit.fill,
                      controller: aniController,
                      onLoaded: (composition) {
                        aniController.duration = composition.duration;
                        aniController.repeat();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => Text(
                      songPlayerController.songTitle.value,
                      style: MytextStyle.customWhiteHeadings,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Obx(
                    () => Text(
                      songPlayerController.songArtist.value,
                      style: MytextStyle.customWhiteHeadings1,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          songPlayerController.currentTime.value,
                          style: TextStyle(color: ColorConstants.customWhite),
                        ),
                        Slider(
                          inactiveColor: ColorConstants.customWhite,
                          activeColor: ColorConstants.customBlack1,
                          value: songPlayerController.sliderValue.value.clamp(
                              0.0, songPlayerController.sliderValue.value),
                          onChanged: (value) {
                            songPlayerController.sliderValue.value = value;
                            Duration songPosition =
                                Duration(seconds: value.toInt());
                            songPlayerController.sliderChange(songPosition);
                          },
                          min: 0,
                          max: songPlayerController.sliderMaxValue.value,
                        ),
                        Text(
                          songPlayerController.totalTime.value,
                          style: TextStyle(color: ColorConstants.customWhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              songDataController.previousSongPlay();
                            },
                            icon: Icon(Icons.skip_previous,
                                size: 40, color: ColorConstants.customWhite1)),
                        Obx(
                          () => songPlayerController.isPlaying.value
                              ? InkWell(
                                  onTap: () {
                                    songPlayerController.pausePlaying();
                                    aniController.stop();
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          ColorConstants.customWhite1,
                                      child: Icon(Icons.pause,
                                          color: ColorConstants.customGrey1)),
                                )
                              : InkWell(
                                  onTap: () {
                                    songPlayerController.resumePlaying();
                                    aniController.repeat();
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          ColorConstants.customWhite1,
                                      child: Icon(Icons.play_arrow,
                                          color: ColorConstants.customGrey1)),
                                ),
                        ),
                        IconButton(
                            onPressed: () {
                              songDataController.nextSongPlay();
                            },
                            icon: Icon(Icons.skip_next,
                                size: 40, color: ColorConstants.customWhite1)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            // left: 3,
            top: 6,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: IconButton(
                  color: ColorConstants.customWhite,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageScreen(),
                        ));
                  },
                  icon: Hero(
                    tag: "myImage",
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
