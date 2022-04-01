// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/controller/home_controller.dart';
import 'package:hd_wallpaper/screens/downloadView.dart';
import 'package:hd_wallpaper/screens/favourite.dart';
import 'package:hd_wallpaper/screens/gridWidget.dart';
import 'package:hd_wallpaper/screens/searchView.dart';

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 19, 15, 19),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 19, 15, 19),
            title: Text(
              'HD Wallpaper',
              style: theme.textTheme.headline2,
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
                return TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    !connected
                            ? Center(
                                child: Image.asset(
                                'assets/no_signal.png',
                                height: height * 0.07,
                              ))
                            : 
                    controller.state
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
                );
              }),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    final theme = Theme.of(context);
    return (await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  // title: Text(
                  //   "Warning",textAlign:TextAlign.center,style:TextStyle(color:Colors.red)
                  // ),
                  content: Text("Do you want to quit?",
                      style: TextStyle(color: Colors.white)),
                  actions: [
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child:
                            Text("Yes", style: TextStyle(color: Colors.red))),
                    TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: Text("No", style: TextStyle(color: Colors.red)))
                  ],
                ))) ??
        false;
  }
}
