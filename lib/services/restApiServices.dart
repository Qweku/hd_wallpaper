import 'dart:convert';

import 'package:hd_wallpaper/model/wallpaper.dart';
import 'package:http/http.dart' as http;

class RestApiService {
  Future<List<dynamic>> getJsonDataFromApi(String url) async {
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    var parseData = jsonDecode(response.body) as List<dynamic>;
    return parseData;
  }

  Future<List<Wallpaper>> convertJsonToObject(String url) async {
    List<dynamic> list = await getJsonDataFromApi(url);
    List<Wallpaper> wallpapers = [];
    for (var wallpaper in list) {
      wallpapers.add(Wallpaper.fromJson(wallpaper));
    }
    return wallpapers;
  }

  // Future<List<Wallpaper>> getWallpapers(String query) async {
  //   List<dynamic> wlist = await getJsonDataFromApi(query);
  // }
}
