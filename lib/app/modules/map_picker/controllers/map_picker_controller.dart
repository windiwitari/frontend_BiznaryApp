import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapPickerController extends GetxController {
  final MapController mapController = MapController();
  
  var selectedLocation = LatLng(-6.2243, 106.8115).obs;
  var selectedPlaceName = "Mencari lokasi...".obs;
  var selectedAddress = "Sedang mengambil alamat...".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil alamat untuk posisi awal saat pertama kali buka
    getAddressFromLatLng(selectedLocation.value);
  }

  void updateLocation(LatLng position) {
    selectedLocation.value = position;
    getAddressFromLatLng(position);
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    isLoading.value = true;
    try {
      // API Nominatim (OpenStreetMap Geocoding)
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1'
      );

      final response = await http.get(url, headers: {
        'User-Agent': 'Biznary_App_Student_Project', // Wajib ada agar tidak di-block
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Ambil nama tempat atau jalan
        String displayTitle = data['address']['road'] ?? 
                             data['address']['suburb'] ?? 
                             "Lokasi Terpilih";
        
        selectedPlaceName.value = displayTitle;
        selectedAddress.value = data['display_name'] ?? "Alamat tidak ditemukan";
      }
    } catch (e) {
      selectedPlaceName.value = "Error";
      selectedAddress.value = "Gagal memuat alamat. Cek koneksi internet.";
    } finally {
      isLoading.value = false;
    }
  }
}

// import 'package:get/get.dart';

// class MapPickerController extends GetxController {
//   //TODO: Implement MapPickerController

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void increment() => count.value++;
// }
