import 'package:hd_wallpaper/controller/base_controller.dart';
import 'package:hive/hive.dart';

import '../model/wallpaper.dart';
import '../utils/constants.dart';

class FavouriteController extends BaseController {
  Box<Wallpaper>? favoriteBox;
  bool isFavourite = false;

  @override
  void onInit() {
    favoriteBox = Hive.box<Wallpaper>(favouriteBox);
    super.onInit();
  }

  void addToFavouriteList(Wallpaper data) {
    Wallpaper wallpaper = Wallpaper(
        description: data.description,
        altDescription: data.altDescription,
        urls: data.urls);
    favoriteBox!.put(wallpaper.urls.regular, wallpaper);
  }

  void deleteFromList(String key) {
    favoriteBox!.delete(key);
  }

  void inTheList(String key) {
    var value = favoriteBox!.get(key);
    if (value == null) {
      isFavourite = false;
    } else {
      isFavourite = true;
    }
  }

  void favouriteToggler(Wallpaper data) {
    isFavourite = !isFavourite;
    if (isFavourite) {
      addToFavouriteList(data);
    } else {
      deleteFromList(data.urls.regular);
    }
    update();
  }
}
