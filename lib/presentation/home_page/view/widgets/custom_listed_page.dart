// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:muzik/core/constants/color.dart';

import 'package:muzik/presentation/home_page/controller/song_data_controller.dart';
import 'package:muzik/presentation/home_page/controller/song_player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListedPage extends StatefulWidget {
  const CustomListedPage({
    super.key,
    required this.songName,
    required this.onPressed,
    // required this.img,
    required this.artist,
    required this.image,
    required this.images,
  });

  final String songName;
  // final String img;
  final String artist;
  final VoidCallback onPressed;
  final int image;
  final String images;

  @override
  State<CustomListedPage> createState() => _CustomListedPageState();
}

class _CustomListedPageState extends State<CustomListedPage> {
  SongDataController songDataController = Get.put(SongDataController());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) => InkWell(
              onTap: widget.onPressed,
              child: Container(
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            color: const Color.fromARGB(255, 78, 64, 63),
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     image: DecorationImage(
                            //         image: AssetImage(
                            //             "assets/images/song_icon.jpg"),
                            //         fit: BoxFit.cover)),
                            child: QueryArtworkWidget(
                              id: widget.image,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          SizedBox(width: 18),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  widget.songName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.customWhite),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  widget.artist,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: ColorConstants.customWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    ],
                  ),
                ),
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: 1);
  }
}
