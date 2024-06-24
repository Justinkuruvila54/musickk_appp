// ignore_for_file: avoid_print, invalid_use_of_protected_member, avoid_function_literals_in_foreach_calls, unnecessary_import

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:musizk_app/presentation/home_page/controller/song_player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongDataController extends GetxController {
  SongPlayerController songPlayerController = Get.put(SongPlayerController());

  final audioQuery = OnAudioQuery();

  RxList<SongModel> songList = <SongModel>[].obs;
  RxBool isDeviceSongs = false.obs;
  RxInt currentSongIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    storagePermission();
  }

  void getLocalSongs() async {
    songList.value = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL);
    isDeviceSongs.value = songList.isNotEmpty;
  }

  Future<void> storagePermission() async {
    try {
      var permission = await Permission.storage.request();
      if (permission.isGranted) {
        print("permission granted");
        getLocalSongs();
      } else {
        print("permission denied");
        Permission.storage.request();
      }
    } catch (exception) {
      print(exception);
    }
  }

  void currentIndex(int songId) {
    var index = 0;
    songList.forEach((element) {
      if (element.id == songId) {
        currentSongIndex.value = index;
      }
      index++;
    });
  }

  void nextSongPlay() {
    if (currentSongIndex.value < songList.length - 1) {
      currentSongIndex.value++;
      SongModel next = songList[currentSongIndex.value];
      songPlayerController.playLocalAudio(next);
    }
  }

  void previousSongPlay() {
    if (currentSongIndex.value > 0) {
      currentSongIndex.value--;
      SongModel previous = songList[currentSongIndex.value];
      songPlayerController.playLocalAudio(previous);
    }
  }
}
