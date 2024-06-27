import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:muzik/core/constants/color.dart';
import 'package:muzik/presentation/home_page/controller/song_data_controller.dart';
import 'package:muzik/presentation/home_page/controller/song_player_controller.dart';
import 'package:muzik/presentation/home_page/view/song_page.dart';

class HeroWidgetScreen extends StatefulWidget {
  const HeroWidgetScreen({
    super.key,
  });

  @override
  State<HeroWidgetScreen> createState() => _HeroWidgetScreenState();
}

class _HeroWidgetScreenState extends State<HeroWidgetScreen> {
  final SongPlayerController songPlayerController =
      Get.put(SongPlayerController());
  final SongDataController songDataController = Get.put(SongDataController());
  bool isMiniPlayerVisible = true; // Add this flag

  @override
  Widget build(BuildContext context) {
    return isMiniPlayerVisible // Use this flag to control visibility
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: Hero(
                tag: "myImage",
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPageScreen(),
                        ));
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.sizeOf(context).width / 1.18,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(137, 30, 4, 57),
                        borderRadius: BorderRadius.circular(1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/get_screen.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 18),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                songPlayerController
                                                    .songTitle.value,
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: ColorConstants
                                                      .customWhite,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                songPlayerController
                                                    .songArtist.value,
                                                //overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: ColorConstants
                                                      .customWhite,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Row(
                                  children: [
                                    Obx(
                                      () => InkWell(
                                        onTap: () {
                                          if (songPlayerController
                                              .isPlaying.value) {
                                            songPlayerController.pausePlaying();
                                            // aniController.stop();  // Uncomment if using animation
                                          } else {
                                            songPlayerController
                                                .resumePlaying();
                                            // aniController.repeat();  // Uncomment if using animation
                                          }
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              ColorConstants.customWhite1,
                                          child: Icon(
                                            songPlayerController.isPlaying.value
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: ColorConstants.customGrey1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                              ],
                            ),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    songPlayerController.currentTime.value,
                                    style: TextStyle(
                                        color: ColorConstants.customWhite),
                                  ),
                                  Slider(
                                    inactiveColor: ColorConstants.customWhite,
                                    activeColor: ColorConstants.customBlack1,
                                    value: songPlayerController
                                        .sliderValue.value
                                        .clamp(
                                            0.0,
                                            songPlayerController
                                                .sliderValue.value),
                                    onChanged: (value) {
                                      songPlayerController.sliderValue.value =
                                          value;
                                      Duration songPosition =
                                          Duration(seconds: value.toInt());
                                      songPlayerController
                                          .sliderChange(songPosition);
                                    },
                                    min: 0,
                                    max: songPlayerController
                                        .sliderMaxValue.value,
                                  ),
                                  Text(
                                    songPlayerController.totalTime.value,
                                    style: TextStyle(
                                        color: ColorConstants.customWhite),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                songPlayerController
                                    .pausePlaying(); // Pause the song
                                setState(() {
                                  isMiniPlayerVisible =
                                      false; // Update the state to close the mini player
                                });
                              },
                              icon: Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 101, 78, 78),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(); // Return an empty container or some other widget when the mini player is not visible
  }
}
