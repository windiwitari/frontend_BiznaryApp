import 'package:biznary/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../core/widgets/biznary_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Biznary", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle, color: Colors.grey),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildFeatureIntro(),
            _buildFeatureCards(),
            _buildBottomCTA(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // 1. Hero Section (Header Utama)
  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black, height: 1.2),
              children: [
                TextSpan(text: "Temukan Ide Bisnis\nTerbaik untuk "),
                TextSpan(text: "Lokasimu", style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/landing_hero.png', // Sesuaikan path asset Anda
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          BiznaryButton(
            text: "Mulai Analisis",
            onPressed: () => Get.offAllNamed('/map-picker'),
          ),
        ],
      ),
    );
  }

  // 2. Deskripsi Fitur
  Widget _buildFeatureIntro() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          const Text(
            "Fitur Utama Biznary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Didesain khusus untuk membantu pengusaha dan mahasiswa IT dalam menentukan peluang bisnis yang akurat.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // 3. Kartu Fitur (Sesuai Gambar)
  Widget _buildFeatureCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _cardItem(
            icon: Icons.map_outlined,
            title: "Analisis Lokasi",
            desc: "Pilih lokasi di peta dan dapatkan skor viabilitas bisnis secara instan.",
            color: Colors.blue.shade50,
            iconColor: Colors.blue,
          ),
          const SizedBox(height: 16),
          _cardItem(
            icon: Icons.lightbulb_outline,
            title: "Ide Bisnis Terkurasi",
            desc: "Dapatkan rekomendasi bisnis spesifik berdasarkan tren dan permintaan pasar setempat.",
            color: Colors.blue,
            iconColor: Colors.white,
            isDark: true,
          ),
          const SizedBox(height: 16),
          _cardItem(
            icon: Icons.calculate_outlined,
            title: "Estimasi RAB",
            desc: "Rancang anggaran modal usaha Anda dengan perhitungan komponen biaya yang mendetail.",
            color: Colors.white,
            iconColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _cardItem({required IconData icon, required String title, required String desc, required Color color, required Color iconColor, bool isDark = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          const SizedBox(height: 8),
          Text(desc, style: TextStyle(color: isDark ? Colors.white70 : Colors.grey.shade600)),
        ],
      ),
    );
  }

  // 4. Bottom CTA (Section Biru Gelap)
  Widget _buildBottomCTA() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            "Siap Membangun Bisnis Impian?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Get.offAllNamed(Routes.MAP_PICKER),
            child: const Text("Mulai Analisis Sekarang"),
          ),
        ],
      ),
    );
  }

  // 5. Footer Section
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Biznary", style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Platform analisis lokasi bisnis cerdas untuk membantu Anda mengambil keputusan yang tepat."),
          const Divider(height: 40),
          const Text("© 2026 Biznary Team. All Rights Reserved."),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}