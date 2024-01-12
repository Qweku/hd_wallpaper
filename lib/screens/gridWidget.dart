// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/model/wallpaper.dart';
import 'package:hd_wallpaper/screens/previewScreen.dart';

class GridWidget extends StatelessWidget {
  final List<Wallpaper> wallpapers;
  final ScrollController scrollController;
  final bool isLoading;
  const GridWidget(
      {Key? key,
      required this.wallpapers,
      required this.scrollController,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.03, right: height * 0.03, left: height * 0.03),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GridView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.9,
              crossAxisCount: 2,
              //mainAxisSpacing: height * 0.01,
              crossAxisSpacing: height * 0.02,
            ),
            itemCount: wallpapers.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Get.to(() => PreviewScreen(
                  isDownloadView: false,
                  wallpaper: wallpapers[index]));
              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: index.isEven ? height * 0.025 : 0,
                    bottom: index.isOdd ? height * 0.025 : 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: theme.primaryColor,
                        child: wallpapers[index].urls.regular.isEmpty
                            ? Center(
                                child: Text('Sorry, no wallpapers',
                                    style: theme.textTheme.bodyMedium))
                            : Hero(
                                tag: wallpapers[index].urls.regular,
                                child: Image.network(
                                    wallpapers[index].urls.regular,
                                    fit: BoxFit.cover),
                              ))),
              ),
            ),
          ),
          isLoading
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color: theme.primaryColor),
                        )),
              )
              : Container()
        ],
      ),
    );
  }
}
