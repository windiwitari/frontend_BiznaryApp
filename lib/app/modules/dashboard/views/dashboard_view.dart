import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../home/views/home_view.dart';
import '../../saved/views/saved_view.dart';
import '../../reports/views/reports_view.dart';
import '../../profile/views/profile_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Obx digunakan untuk mengganti halaman secara reaktif
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              // Urutan ke-0: Ini yang akan muncul pertama kali saat masuk dari Home
              const HomeView(),
              // Urutan ke-1, ke-2, ke-3: Ini yang akan muncul saat user klik di BottomNavigationBar
              const ReportsView(),
              const SavedView(),
              const ProfileView(),
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) => controller.changePage(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "Reports"),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: "Saved"),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Profile"),
            ],
          )),
    );
  }
}