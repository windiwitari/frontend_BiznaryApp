import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import '../controllers/map_picker_controller.dart';
import '../../../core/widgets/biznary_button.dart';

class MapPickerView extends GetView<MapPickerController> {
  const MapPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // --- TOMBOL KEMBALI DIBAWAH INI ---
       leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A56BE)),
          onPressed: () {
            if (Get.previousRoute == '/dashboard') {
              Get.back();
            } else {
              Get.offAllNamed('/dashboard');
            }
          },
        ),
        // ----------------------------------
        title: const Text("Biznary", style: TextStyle(color: Color(0xFF1A56BE), fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(backgroundColor: Colors.grey.shade200, child: const Icon(Icons.person_outline, color: Colors.blue)),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. OpenStreetMap Widget
          Obx(() => FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: controller.selectedLocation.value,
                  initialZoom: 15,
                  onTap: (tapPosition, point) => controller.updateLocation(point),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.biznary.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.selectedLocation.value,
                        width: 80,
                        height: 80,
                        child: const Icon(Icons.location_on, color: Color(0xFF1A56BE), size: 45),
                      ),
                    ],
                  ),
                ],
              )),

          // 2. Overlay UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildLocationCard(),
                  const Spacer(),
                  BiznaryButton(
                    text: "Gunakan Lokasi Ini",
                    onPressed: () => Get.toNamed('/business-form'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Lokasi ini akan digunakan sebagai basis analisis Idea Engine",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFF1A56BE)),
          hintText: "Cari lokasi...",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.95),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 15),
      ],
    ),
    child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.apartment, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "LOKASI TERPILIH",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        controller.isLoading.value 
                            ? "Mengambil data..." 
                            : controller.selectedPlaceName.value,
                        style: const TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              controller.isLoading.value 
                  ? "Mohon tunggu sebentar..." 
                  : controller.selectedAddress.value,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildBadge(Icons.speed, "Akses Cepat"),
                const SizedBox(width: 8),
                _buildBadge(Icons.security, "Area Aman"),
              ],
            ),
          ],
        )),
  );
}

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.blue),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}