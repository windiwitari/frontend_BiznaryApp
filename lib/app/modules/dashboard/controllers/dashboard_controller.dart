import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Index halaman saat ini
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}