import 'package:biznary/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
// Import semua controller yang error
import '../controllers/dashboard_controller.dart';
import '../../map_picker/controllers/map_picker_controller.dart';
import '../../reports/controllers/reports_controller.dart';
import '../../saved/controllers/saved_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Controller utama Dashboard
    Get.lazyPut<DashboardController>(() => DashboardController());

    // 2. Tambahkan controller anak agar tidak error "not found"
    Get.lazyPut<MapPickerController>(() => MapPickerController());
    Get.lazyPut<ReportsController>(() => ReportsController());
    Get.lazyPut<SavedController>(() => SavedController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}