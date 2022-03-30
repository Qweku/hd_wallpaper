import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hd_wallpaper/model/wallpaper.dart';
import 'package:hd_wallpaper/services/restApiServices.dart';

import '../utils/constants.dart';
import 'base_controller.dart';

class HomeController extends BaseController {
  final RestApiService _restApiService = RestApiService();
  final ScrollController todayScrollController = ScrollController();
  final ScrollController popularScrollController = ScrollController();
  final ScrollController oldestScrollController = ScrollController();

  List<Wallpaper> todaysList = [];
  List<Wallpaper> popularList = [];
  List<Wallpaper> oldestList = [];

  int currentPageNumber = 2;
  int currentPageNumberP = 2;
  int currentPageNumberO = 2;

  bool isLoading = false;

  Future<void> getListOfToday() async {
    setState(true);
    todaysList = await _restApiService.convertJsonToObject(api + "&page=${1}");
    setState(false);
  }

  Future<void> getListOfPopular() async {
    setState(true);
    popularList = await _restApiService
        .convertJsonToObject(api + "&page=${1}&order_by=popular");
    setState(false);
  }

  Future<void> getListOfOldest() async {
    setState(true);
    oldestList = await _restApiService
        .convertJsonToObject(api + "&${1}&order_by=oldest");
    setState(false);
  }

//========================Today List Scroll controller=============
  void loadMoreData() {
    todayScrollController.addListener(() async {
      if (todayScrollController.position.pixels ==
          todayScrollController.position.maxScrollExtent) {
        await addMoreDataToday();
      }
    });
  }

  Future<void> addMoreDataToday() async {
    setBottomState(true);
    List<Wallpaper> wallpapers = [];
    wallpapers = await _restApiService
        .convertJsonToObject(api + "&page=$currentPageNumber");
    currentPageNumber++;
    todaysList.addAll(wallpapers);
    setBottomState(false);
  }

//========================Popular List Scroll Controller=====================

  void loadMoreDataPopular() {
    popularScrollController.addListener(() async {
      if (popularScrollController.position.pixels ==
          popularScrollController.position.maxScrollExtent) {
        await addMoreDataPopular();
      }
    });
  }

  Future<void> addMoreDataPopular() async {
    setBottomState(true);
    List<Wallpaper> wallpapers = [];
    wallpapers = await _restApiService.convertJsonToObject(
        api + "&page=$currentPageNumberP&order_by=popular");
    currentPageNumberP++;
    popularList.addAll(wallpapers);
    setBottomState(false);
  }

  //========================Popular List Scroll Controller=====================

  void loadMoreDataOldest() {
    oldestScrollController.addListener(() async {
      if (oldestScrollController.position.pixels ==
          oldestScrollController.position.maxScrollExtent) {
        await addMoreDataOldest();
      }
    });
  }

  Future<void> addMoreDataOldest() async {
    setBottomState(true);
    List<Wallpaper> wallpapers = [];
    wallpapers = await _restApiService
        .convertJsonToObject(api + "&page=$currentPageNumberO&order_by=oldest");
    currentPageNumberO++;
    oldestList.addAll(wallpapers);
    setBottomState(false);
  }

  void getAllData() async {
    setState(true);
    await getListOfToday();
    await getListOfPopular();
    await getListOfOldest();
    setState(false);
  }

  @override
  void onInit() {
    getAllData();
    loadMoreData();
    loadMoreDataPopular();
    loadMoreDataOldest();
    super.onInit();
  }

  // @override
  // void onClose() {
  //   todayScrollController.dispose();
  //   popularScrollController.dispose();
  //   oldestScrollController.dispose();
  //   super.onClose();
  // }
}
