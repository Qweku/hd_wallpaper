import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/controller/home_controller.dart';
import 'package:hd_wallpaper/model/urls.dart';
import 'package:hd_wallpaper/model/wallpaper.dart';
import 'package:hd_wallpaper/services/restApiServices.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late List<Wallpaper> wallpaperSearch = [];
  String query = '';
  Wallpaper wallpaper = Wallpaper(
      urls: Urls(regular: '', small: ''), description: "", altDescription: "");
  HomeController controller = HomeController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 15, 19),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 19, 15, 19),
        title: TextField(
          style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
          onChanged: ((value) => controller.filterWallpaper(value)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: theme.primaryColor),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.only(
              top: height * 0.03, right: height * 0.03, left: height * 0.03),
          child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return controller.foundWallpaper.value.isEmpty
                    ? const Center(child: Text('No Wallpapers'))
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 2.9,
                          crossAxisCount: 2,
                          //mainAxisSpacing: height * 0.01,
                          crossAxisSpacing: height * 0.02,
                        ),
                        itemCount: controller.foundWallpaper.value.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.to(() => PreviewScreen(
                              //     isDownloadView: false,
                              //     wallpaper: wallpaper!));
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
                                        tag: "",
                                        child: Image.network(
                                            controller.foundWallpaper
                                                .value[index].urls.regular,
                                            // wallpaper.urls.regular,
                                            fit: BoxFit.cover),
                                      ))),
                            ),
                          );
                        });
              })),
    );
  }

  Future<void> searchWallpaper(String query) async {
    final wallpaperSearch = await RestApiService().convertJsonToObject(query);
    if (!mounted) return;

    setState(() {
      this.query = query;
      this.wallpaperSearch = wallpaperSearch;
    });
  }
}
