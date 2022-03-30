import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';

import 'download_controller.dart';

class WallpaperController extends DownloadController {
  Future<void> downloadWallpaper(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    insertImagePath(url, file.path);
    Get.showSnackbar(const GetSnackBar(
      padding: EdgeInsets.all(12),
      backgroundColor: Color.fromARGB(255, 1, 162, 255),
      borderRadius: 40,
      titleText: Center(child: Text('Done')),
      messageText: Center(child: Text('Download Complete')),
      duration: Duration(seconds: 2),
    ));
  }


//===========SET HOME SCREEN WALLPAPER=====================================
  Future<void> setOnHomeScreen(String? url, String? pathName, bool? isDownload) async {
    if(isDownload!){
      await homeScreen(pathName!);
    }else{
 var filePath = await cacheWallpaper(url!);
    await homeScreen(filePath.path);
    }
   
     Get.showSnackbar(const GetSnackBar(
      padding: EdgeInsets.all(12),
      backgroundColor: Color.fromARGB(255, 1, 162, 255),
      borderRadius: 40,
      titleText: Center(child: Text('Done')),
      messageText: Center(child: Text('Set on home screen')),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> setOnLockScreen(String? url, String? pathName, bool? isDownload) async {
    if(isDownload!){
      await lockScreen(pathName!);
    }else{
      var filePath = await cacheWallpaper(url!);
    await lockScreen(filePath.path);
    }
    
     Get.showSnackbar(const GetSnackBar(
      padding: EdgeInsets.all(12),
      backgroundColor: Color.fromARGB(255, 1, 162, 255),
      borderRadius: 40,
      titleText: Center(child: Text('Done')),
      messageText: Center(child: Text('Set on lock screen')),
      duration: Duration(seconds: 2),
    ));
  }


Future<void> setOnBothScreen(String? url, String? pathName, bool? isDownload) async {
    if(isDownload!){
      await homeLockScreen(pathName!);
    }else{
      var filePath = await cacheWallpaper(url!);
    await homeLockScreen(filePath.path);

    }
         Get.showSnackbar(const GetSnackBar(
      padding: EdgeInsets.all(12),
      backgroundColor: Color.fromARGB(255, 1, 162, 255),
      borderRadius: 40,
      titleText: Center(child: Text('Done')),
      messageText: Center(child: Text('Set on home and lock screen')),
      duration: Duration(seconds: 2),
    ));
  }



//=======================SCREENS=====================================
  Future<void> homeScreen(String path) async {
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.HOME_SCREEN);
  }
  Future<void> lockScreen(String path) async {
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.LOCK_SCREEN);
  }
  Future<void> homeLockScreen(String path) async {
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.BOTH_SCREEN);
  }


//==============================DOWNLOAD FIRST=====================================
  Future<File> cacheWallpaper(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }
}
