import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/model/urls.dart';
import 'package:hd_wallpaper/screens/launcher.dart';
import 'package:hd_wallpaper/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/wallpaper.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UrlsAdapter());
  Hive.registerAdapter(WallpaperAdapter());
  await Hive.openBox<Wallpaper>(favouriteBox);
  await Hive.openBox<String>(downloadBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HD Wallpaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Federo',
          primaryColor: Color.fromARGB(255, 255, 94, 1),
          primaryColorLight: const Color.fromARGB(255, 223, 174, 26),
          primaryColorDark: const Color.fromARGB(255, 19, 15, 19),
          textTheme: const TextTheme(
              displayLarge: TextStyle(fontSize: 20, color: Colors.black),
              displayMedium: TextStyle(fontSize: 20, color: Colors.white),
              bodyLarge: TextStyle(fontSize: 14, color: Colors.black),
              bodyMedium: TextStyle(fontSize: 14, color: Colors.white))),
      home: const Launcher(),
    );
  }
}
