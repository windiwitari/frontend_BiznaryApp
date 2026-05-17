import 'dart:io';
import 'package:flutter/foundation.dart'
    show kIsWeb; // PENTING: Untuk cek deteksi Web vs Mobile
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/widgets/biznary_button.dart';
import '../../../core/widgets/category_card.dart';
import '../controllers/business_form_controller.dart';

class BusinessFormView extends GetView<BusinessFormController> {
  const BusinessFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text(
          "Pilih Kategori Bisnis",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tentukan sektor usaha yang ingin Anda kembangkan.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // --- SECTION KATEGORI ---
            Obx(
              () => Column(
                children: [
                  CategoryCard(
                    title: "Kuliner",
                    subtitle: "Restoran, Cafe, & Cloud Kitchen",
                    icon: Icons.restaurant,
                    isSelected: controller.selectedCategory.value == "Kuliner",
                    onTap: () => controller.selectedCategory.value = "Kuliner",
                  ),
                  CategoryCard(
                    title: "Otomotif",
                    subtitle: "Jasa & Konsultasi",
                    icon: Icons.directions_car,
                    isSelected: controller.selectedCategory.value == "Otomotif",
                    onTap: () => controller.selectedCategory.value = "Otomotif",
                  ),
                  CategoryCard(
                    title: "Salon - Barbershop",
                    subtitle: "Kecantikan & Rambut",
                    icon: Icons.content_cut,
                    isSelected: controller.selectedCategory.value == "Salon",
                    onTap: () => controller.selectedCategory.value = "Salon",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              "Berapa modal yang Anda siapkan?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1D212D),
              ),
            ),
            const SizedBox(height: 16),

            // --- INPUT TEXT FIELD MODAL ---
            TextField(
              controller:
                  controller.modalController, // Form terikat ke controller aman
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixText: "Rp ",
                prefixStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                hintText: "50.000.000",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF1A56BE),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // --- SECTION UPLOAD FOTO ---
            _buildUploadSection(),

            const SizedBox(height: 40),

            // --- TOMBOL SUBMIT (BYPASS CONTROLLER ANTI CRASH) ---
            BiznaryButton(
              text: "Analisis Sekarang",
              onPressed: () {
                // 1. Ambil nilai kategori secara aman, berikan fallback langsung jika null
                String kategoriTerpilih = "Kuliner";
                try {
                  kategoriTerpilih = controller.selectedCategory.value;
                  if (kategoriTerpilih.isEmpty) kategoriTerpilih = "Kuliner";
                } catch (_) {
                  kategoriTerpilih =
                      "Kuliner"; // Jika controller sudah null, paksa isi Kuliner
                }

                // 2. Ambil nilai modal secara aman langsung dari textfield
                String modalText = "50000000";
                try {
                  if (controller.modalController.text.isNotEmpty) {
                    modalText = controller.modalController.text.replaceAll(
                      '.',
                      '',
                    );
                  }
                } catch (_) {
                  modalText =
                      "50000000"; // Jika controller teks null, gunakan fallback
                }

                int modalInput = int.tryParse(modalText) ?? 50000000;

                // 3. Ambil path gambar secara aman
                String pathGambar = "";
                try {
                  pathGambar = controller.selectedImagePath.value;
                } catch (_) {
                  pathGambar = "";
                }

                // 4. Eksekusi perpindahan halaman dengan data yang sudah di-KUNCI (Aman dari Null)
                Get.toNamed(
                  '/reports',
                  arguments: {
                    'category': kategoriTerpilih,
                    'modal': modalInput,
                    'image_path': pathGambar,
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Foto Lokasi (Opsional)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1D212D),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "Unggah foto sekitar lokasi untuk analisis visual AI.",
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isLoadingImage.value) {
            return Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100, width: 2),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A56BE)),
                ),
              ),
            );
          }

          if (controller.selectedImagePath.value.isEmpty) {
            return InkWell(
              onTap: () => _showPickerOption(),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade100, width: 2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      color: Color(0xFF1A56BE),
                      size: 30,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Tambah Foto Lokasi",
                      style: TextStyle(
                        color: Color(0xFF1A56BE),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // RENDER PREVIEW (DIPERBAIKI SECARA ABSOLUT DARI TRANSLATION NULL)
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:
                      kIsWeb ||
                          controller.selectedImagePath.value.startsWith('blob:')
                      ? Image.network(
                          controller.selectedImagePath.value,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(controller.selectedImagePath.value),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => controller.removeImage(),
                  child: CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.9),
                    radius: 15,
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  void _showPickerOption() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            const Text(
              "Pilih Sumber Foto",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF1A56BE)),
              title: const Text("Kamera"),
              onTap: () {
                controller.pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFF1A56BE),
              ),
              title: const Text("Galeri"),
              onTap: () {
                controller.pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
