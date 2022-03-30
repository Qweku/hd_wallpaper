import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controller/download_controller.dart';
import '../controller/favourite_controller.dart';
import '../model/urls.dart';
import '../model/wallpaper.dart';
import 'previewScreen.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 15, 19),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 19, 15, 19),
        title: Text(
          'Downloads',
          style: theme.textTheme.headline2,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const DownloadGridView(),
    );
  }
}

class DownloadGridView extends StatelessWidget {
  const DownloadGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.03, right: height * 0.03, left: height * 0.03),
      child: GetBuilder<DownloadController>(
          init: DownloadController(),
          builder: (controller) {
            return ValueListenableBuilder(
                valueListenable: controller.downloadBoxListner!.listenable(),
                builder: (context, Box<String> box, child) {
                  final List<String> keys = box.keys.cast<String>().toList();
                  return keys.isEmpty
                      ? const Center(child: Text('No Favourite Wallpapers'))
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 2.9,
                            crossAxisCount: 2,
                            //mainAxisSpacing: height * 0.01,
                            crossAxisSpacing: height * 0.02,
                          ),
                          itemCount: keys.length,
                          itemBuilder: (context, index) {
                            final String key = keys[index];
                            final String? wallpaper = box.get(key);
                            File file = File(wallpaper!);
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => PreviewScreen(
                                      isDownloadView: true,
                                      wallpaper: 
                                    Wallpaper(
                                      description: "",
                                      altDescription: "",
                                      urls: Urls(regular:wallpaper,small:'')
                                      )
                                ));
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
                                          tag:file,
                                          child: Image.file(
                                              file,
                                              fit: BoxFit.cover),
                                        ))),
                              ),
                            );
                          });
                });
          }),
    );
  }
}
