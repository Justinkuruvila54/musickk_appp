import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteController extends GetxController {
  SongModel? songs;
  static List favKeys = [];

  var myBox = Hive.box('fav');

  void addFav({
    required String title,
    required String author,
  }) {
    myBox.add({
      "title": title,
      "author": author,
    });
  }

  void deleteData(int index) {
    myBox.deleteAt(index);
    favKeys = myBox.keys.toList();
  }
}
