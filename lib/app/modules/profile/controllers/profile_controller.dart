import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Data Profil Pengguna
  var userName = "User Biznary".obs;
  var userEmail = "biznary@student.uhn.ac.id".obs;
  var userRole = "user".obs;
  
  // Statistik
  var savedConcepts = 12.obs;
  var totalReports = 8.obs;

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      onConfirm: () => Get.offAllNamed('/auth'),
      onCancel: () => Get.back(),
    );
  }
}