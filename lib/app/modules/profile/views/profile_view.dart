import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text("Profil Saya", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStatsSection(),
            const SizedBox(height: 20),
            _buildMenuSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Colors.white,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFFD6E4FF),
            child: Icon(Icons.person, size: 60, color: Color(0xFF1A56BE)),
          ),
          const SizedBox(height: 15),
          Obx(() => Text(controller.userName.value, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          Obx(() => Text(controller.userRole.value, 
              style: const TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _statItem("Konsep", controller.savedConcepts),
          const SizedBox(width: 15),
          _statItem("Laporan", controller.totalReports),
        ],
      ),
    );
  }

  Widget _statItem(String label, RxInt value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Obx(() => Text("${value.value}", 
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A56BE)))),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _menuItem(Icons.edit_outlined, "Edit Profil", () {}),
          _menuItem(Icons.security_outlined, "Keamanan Akun", () {}),
          _menuItem(Icons.notifications_none_outlined, "Notifikasi", () {}),
          _menuItem(Icons.help_outline, "Pusat Bantuan", () {}),
          _menuItem(Icons.logout, "Keluar", () => controller.logout(), isLogout: true),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF1A56BE)),
      title: Text(title, style: TextStyle(color: isLogout ? Colors.red : Colors.black87)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}