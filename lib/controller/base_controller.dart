import 'package:get/get.dart';

class BaseController extends GetxController {
  bool _state = false;
  bool get state => _state;
  bool _bottomState = false;
  bool get bottomState => _bottomState;

  void setBottomState(bool value) {
    _bottomState = value;
    update();
  }

  void setState(bool value) {
    _state = value;
    update();
  }
}
