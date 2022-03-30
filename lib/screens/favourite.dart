import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/controller/favourite_controller.dart';
import 'package:hd_wallpaper/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/wallpaper.dart';
import 'previewScreen.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 15, 19),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 19, 15, 19),
        title: Text(
          'Favourite',
          style: theme.textTheme.headline2,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const FavGridView(),
    );
  }
}

class FavGridView extends StatelessWidget {
  const FavGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.03, right: height * 0.03, left: height * 0.03),
      child: GetBuilder<FavouriteController>(
        init:FavouriteController(),
        builder: (controller) {
          return ValueListenableBuilder(
              valueListenable: controller.favoriteBox!.listenable(),
              builder: (context, Box<Wallpaper> box, child) {
                final List<String> keys = box.keys.cast<String>().toList();
                return keys.isEmpty? const Center(child:Text('No Favourite Wallpapers')):GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 2.9,
                      crossAxisCount: 2,
                      //mainAxisSpacing: height * 0.01,
                      crossAxisSpacing: height * 0.02,
                    ),
                    itemCount: keys.length,
                    itemBuilder: (context, index) {
                      final String key = keys[index];
                      final Wallpaper? wallpaper = box.get(key);
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => PreviewScreen(
                            isDownloadView: false,
                            wallpaper: wallpaper!));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: index.isEven ? height * 0.025 : 0,
                              bottom: index.isOdd ? height * 0.025 : 0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  color: theme.primaryColor,
                                  child: Hero(
                                    tag: wallpaper!.urls.regular,
                                    child: Image.network(wallpaper.urls.regular, fit: BoxFit.cover),
                                  ))),
                        ),
                      );
                    });
              });
        }
      ),
    );
  }
}
