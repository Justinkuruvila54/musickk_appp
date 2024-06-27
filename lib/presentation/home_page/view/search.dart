import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:muzik/presentation/home_page/controller/song_data_controller.dart';
import 'package:muzik/presentation/home_page/controller/song_player_controller.dart';
import 'package:muzik/presentation/home_page/view/song_page.dart';
import 'package:muzik/presentation/home_page/view/widgets/custom_listed_page.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SongDataController songDataController = Get.find();
  final SongPlayerController songPlayerController = Get.find();
  RxList filteredSongs = [].obs;

  @override
  void initState() {
    super.initState();
    _filterSongs(widget.query);
  }

  void _filterSongs(String query) {
    query = query.toLowerCase();
    if (query.isEmpty) {
      filteredSongs.value = songDataController.songList.value;
    } else {
      filteredSongs.value = songDataController.songList.value
          .where((song) =>
              song.title.toLowerCase().contains(query) ||
              (song.artist?.toLowerCase().contains(query) ?? false))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Obx(
        () => ListView(
          children: filteredSongs
              .map((e) => CustomListedPage(
                    songName: e.title,
                    artist: e.artist!,
                    onPressed: () {
                      songPlayerController.playLocalAudio(e);
                      songDataController.currentIndex(e.id);
                      Get.to(() => SongPageScreen(details: e));
                    },
                    image: e.id,
                    images: '',
                  ))
              .toList(),
        ),
      ),
    );
  }
}
