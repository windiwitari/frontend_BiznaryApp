import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BusinessFormController extends GetxController {
  // Nilai default untuk form input
  var selectedCategory = 'Kuliner'.obs; 
  var selectedImagePath = ''.obs;
  var isLoadingImage = false.obs;

  // Deklarasikan text controller untuk modal
  late TextEditingController modalController;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi awal dengan nilai string tanpa titik agar mudah di-parse
    modalController = TextEditingController(text: "50000000"); 
  }

  @override
  void onClose() {
    modalController.dispose(); // Mencegah memory leak
    super.onClose();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      isLoadingImage.value = true;
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        selectedImagePath.value = image.path;
        selectedImagePath.refresh();
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil gambar: $e");
    } finally {
      isLoadingImage.value = false;
    }
  }

  void removeImage() {
    selectedImagePath.value = '';
    selectedImagePath.refresh();
  }
}