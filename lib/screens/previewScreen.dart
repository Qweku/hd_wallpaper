// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/controller/favourite_controller.dart';
import 'package:hd_wallpaper/controller/wallpaper_controller.dart';
import 'package:hd_wallpaper/model/wallpaper.dart';

class PreviewScreen extends StatelessWidget {
  final Wallpaper wallpaper;
  final bool isDownloadView;
  const PreviewScreen(
      {Key? key, required this.wallpaper, required this.isDownloadView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(children: [
        isDownloadView
            ? Hero(
                tag: wallpaper.urls.regular,
                child: Image.file(File(wallpaper.urls.regular),
                    height: Get.height,
                    width: double.infinity,
                    fit: BoxFit.cover),
              )
            : Hero(
                tag: wallpaper.urls.regular,
                child: Image.network(wallpaper.urls.regular,
                    height: Get.height,
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: height * 0.02, vertical: height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
              GetBuilder<WallpaperController>(
                  init: WallpaperController(),
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isDownloadView
                            ? Container()
                            : ButtonWidget(
                                isDownloadView: false,
                                onTap: () {
                                  controller.downloadWallpaper(
                                      wallpaper.urls.regular);
                                },
                                theme: theme,
                                label: 'Download',
                                iconColor: Colors.white,
                                backgroundColor: theme.primaryColor,
                                icon: Icons.file_download_outlined,
                              ),
                        ButtonWidget(
                          isDownloadView: false,
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0)),
                                ),
                                context: context,
                                builder: (BuildContext bc) {
                                  double height =
                                      MediaQuery.of(context).size.height;
                                  final theme = Theme.of(context);
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(bottom: height * 0.03),
                                    child: Wrap(
                                      spacing: 40,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              EdgeInsets.all(height * 0.03),
                                          child: Text(
                                            'Set wallpaper as:',
                                            style: theme.textTheme.displayMedium,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BottomSheetButton(
                                                onTap: () {
                                                  controller.setOnHomeScreen(
                                                    wallpaper.urls.regular,
                                                    wallpaper.urls.regular,
                                                    isDownloadView,
                                                  );
                                                  Get.back();
                                                },
                                                wallpaper: wallpaper,
                                                wallpaperController: controller,
                                                icon: Icons.home_outlined,
                                                label: 'Home Screen'),
                                            BottomSheetButton(
                                                onTap: () {
                                                  controller.setOnLockScreen(
                                                    wallpaper.urls.regular,
                                                    wallpaper.urls.regular,
                                                    isDownloadView,
                                                  );
                                                  Get.back();
                                                },
                                                wallpaper: wallpaper,
                                                wallpaperController: controller,
                                                icon: Icons.lock_open,
                                                label: 'Lock Screen'),
                                            BottomSheetButton(
                                                onTap: () {
                                                  controller.setOnBothScreen(
                                                    wallpaper.urls.regular,
                                                    wallpaper.urls.regular,
                                                    isDownloadView,
                                                  );
                                                  Get.back();
                                                },
                                                wallpaper: wallpaper,
                                                wallpaperController: controller,
                                                icon:
                                                    Icons.screen_lock_portrait,
                                                label: 'Home & Lock Screen')
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                });
                          },
                          label: 'Set As',
                          icon: Icons.play_arrow,
                          iconColor: Colors.white,
                          backgroundColor: theme.primaryColor,
                          theme: theme,
                        ),
                        isDownloadView
                            ? Container()
                            : GetBuilder<FavouriteController>(
                                init: FavouriteController(),
                                initState: (con) {
                                  Future.delayed(Duration(seconds: 0))
                                      .then((value) {
                                    con.controller!
                                        .inTheList(wallpaper.urls.regular);
                                  });
                                },
                                builder: (controller) {
                                  return ButtonWidget(
                                      isDownloadView: false,
                                      onTap: () {
                                        controller.favouriteToggler(wallpaper);
                                        print("PRINTED "+wallpaper.urls.regular);
                                      },
                                      theme: theme,
                                      label: 'Like',
                                      iconColor: theme.primaryColor,
                                      backgroundColor: Colors.white,
                                      icon: controller.isFavourite
                                          ? Icons.favorite
                                          : Icons.favorite_border);
                                }),
                      ],
                    );
                  })
            ],
          ),
        )
      ]),
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  final Wallpaper wallpaper;
  final WallpaperController wallpaperController;
  final IconData icon;
  final String? label;
  //final Color? backgroundColor, iconColor;
  final Function()? onTap;
  const BottomSheetButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.label,
    required this.wallpaper,
    required this.wallpaperController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        CircleAvatar(
          radius: height * 0.04,
          backgroundColor: theme.primaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: height * 0.01),
        SizedBox(
          width: width * 0.3,
          child: Text(
            label!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        )
      ]),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String? label;
  final bool isDownloadView;
  final Color? backgroundColor, iconColor;
  final Function()? onTap;
  const ButtonWidget({
    Key? key,
    required this.theme,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.label,
    required this.isDownloadView,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: height * 0.04,
            backgroundColor: backgroundColor,
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(height: height * 0.01),
          Text(label!, style: theme.textTheme.bodyMedium!.copyWith(fontSize: 12))
        ],
      ),
    );
  }
}
