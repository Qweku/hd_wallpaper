import 'package:hive/hive.dart';

import '../utils/constants.dart';
import 'base_controller.dart';

class DownloadController extends BaseController {
  Box<String>? downloadBoxListner;

  void insertImagePath(String url, String path) {
    var box = Hive.box<String>(downloadBox);
    box.put(url, path);
  }

  @override
  void onInit() {
    downloadBoxListner = Hive.box<String>(downloadBox);
    super.onInit();
  }
}
