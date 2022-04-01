import 'package:hd_wallpaper/model/wallpaper.dart';
import 'package:hive/hive.dart';

import '../utils/constants.dart';
import 'home_controller.dart';

class SearchController extends HomeController {
  Box<Wallpaper>? searchBoxListner;
  bool isSearch = false;

  void insertImagePath(String url, Wallpaper path) {
    var box = Hive.box<Wallpaper>(searchBox);
    box.put(url, path);
  }

  void inTheList(String key) {
    var value = searchBoxListner!.get(key);
    if (value == null) {
      isSearch = false;
    } else {
      isSearch = true;
    }
  }

  @override
  void onInit() {
    searchBoxListner = Hive.box<Wallpaper>(searchBox);
    super.onInit();
  }
}
