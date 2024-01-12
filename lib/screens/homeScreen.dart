import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/controller/home_controller.dart';
import 'package:hd_wallpaper/screens/downloadView.dart';
import 'package:hd_wallpaper/screens/favourite.dart';
import 'package:hd_wallpaper/screens/gridWidget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../components/bottomNav.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Widget? _content;

  @override
  void initState() {
    _content = HomeScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNav(onChange: _handleNavigationChange),
        body: _content);
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _content = DownloadView();
          break;
        case 1:
          _content = HomeScreen();
          break;
        case 2:
          _content = FavouriteView();
          break;
      }
      _content = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _content,
      );
    });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool connected = false;
  var result;
  Future<void> connectivity() async {
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      connected = true;
    } else {
      connected = false;
    }
    print('$connected');
  }

  @override
  void initState() {
    connectivity();

    super.initState();
  }

   DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => doubleTapToExit(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor:  theme.primaryColorDark,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: theme.primaryColorDark,
            title: Text(
              'HD Wallpaper',
              style: theme.textTheme.displayMedium,
            ),
            centerTitle: true,
            elevation: 0,
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       Get.to(() => SearchView());
            //     },
            //     icon: Icon(Icons.search, color: theme.primaryColor),
            //   )
            // ],
            bottom: TabBar(
              labelColor: theme.primaryColor,
              //indicatorPadding: EdgeInsets.symmetric(horizontal:50),
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.white,
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const Text('LATEST'),
                const Text('POPULAR'),
                const Text('OLDEST')
              ],
            ),
          ),
          body: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return LiquidPullToRefresh(
                  onRefresh: () async {
                    connectivity();
                    
                    return await Future.delayed(Duration(seconds: 4));
                  },
                  color: theme.primaryColorDark,
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      !connected
                          ? Center(
                              child: Image.asset(
                              'assets/no_signal.png',
                              height: height * 0.07,
                            ))
                          : controller.state
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: theme.primaryColor),
                                )
                              : GridWidget(
                                  isLoading: controller.bottomState,
                                  scrollController:
                                      controller.todayScrollController,
                                  wallpapers: controller.todaysList,
                                ),
                      controller.state
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: theme.primaryColor),
                            )
                          : controller.state
                              ? Center(
                                  child: Image.asset(
                                  'assets/no_signal.png',
                                  height: height * 0.07,
                                ))
                              : GridWidget(
                                  isLoading: controller.bottomState,
                                  scrollController:
                                      controller.popularScrollController,
                                  wallpapers: controller.popularList,
                                ),
                      controller.state
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: theme.primaryColor),
                            )
                          : controller.state
                              ? Center(
                                  child: Image.asset(
                                  'assets/no_signal.png',
                                  height: height * 0.07,
                                ))
                              : GridWidget(
                                  isLoading: controller.bottomState,
                                  scrollController:
                                      controller.oldestScrollController,
                                  wallpapers: controller.oldestList,
                                )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<bool> doubleTapToExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      var theme = Theme.of(context);
      double width = MediaQuery.of(context).size.width;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: width*0.42,
            backgroundColor: theme.primaryColor,
            content: Text('Repeat action to exit',
                textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: const StadiumBorder()),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
