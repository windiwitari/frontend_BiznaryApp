import 'package:get/get.dart';

class ReportsController extends GetxController {
  // Data Modal & Kategori (Memiliki nilai bawaan aman sebagai cadangan)
  var totalModal = 50000000.obs;
  var kategoriUsaha = "Kuliner".obs;
  var rekomendasiUsaha = "Kedai kopi".obs;

  // Data Tabel RAB (Struktur Map dibuat dinamis & aman dari null)
  var listRab = <Map<String, String>>[
    {"komponen": "Sewa Tempat", "detail": "Sewa 1 tahun", "biaya": "15000000"},
    {"komponen": "Renovasi & Desain", "detail": "Interior Minimalis", "biaya": "8000000"},
    {"komponen": "Peralatan", "detail": "Mesin kopi, grinder, dll", "biaya": "12000000"},
    {"komponen": "Bahan baku awal", "detail": "Kopi, susu, gula, dll", "biaya": "15000000"},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    
    // --- PROSES MENANGKAP DATA DARI FORM (ANTI NULL CRASH) ---
    if (Get.arguments != null && Get.arguments is Map) {
      var args = Get.arguments as Map<String, dynamic>;
      
      // Mengisi nilai kategori jika dikirim dari halaman sebelumnya
      if (args['category'] != null && args['category'].toString().isNotEmpty) {
        kategoriUsaha.value = args['category'].toString();
      }
      
      // Mengisi nilai modal jika dikirim dari halaman sebelumnya
      if (args['modal'] != null) {
        totalModal.value = args['modal'] is int ? args['modal'] : int.tryParse(args['modal'].toString()) ?? 50000000;
      }
      
      // Memperbarui rekomendasi jenis usaha secara otomatis berdasarkan kategori form
      if (kategoriUsaha.value == "Otomotif") {
        rekomendasiUsaha.value = "Bengkel & Cuci Motor";
      } else if (kategoriUsaha.value == "Salon") {
        rekomendasiUsaha.value = "Barbershop Modern";
      } else {
        rekomendasiUsaha.value = "Kedai kopi";
      }
    }
  }

  // --- GETTER TOTAL ESTIMASI (SUDAH DIPERBAIKI - BEBAS DARI OPERATOR '!') ---
  int get totalEstimasi {
    int total = 0;
    for (var item in listRab) {
      // Mengambil nilai biaya, jika null ganti dengan string '0'
      String biayaText = item['biaya'] ?? '0';
      
      // Konversi string ke integer secara aman tanpa memaksa pake '!'
      total += int.tryParse(biayaText) ?? 0;
    }
    return total;
  }

  // Getter sisa dana cadangan
  int get sisaDana => totalModal.value - totalEstimasi;

  // Fungsi untuk memformat angka biasa menjadi format mata uang Rupiah
  String formatRupiah(int nominal) {
    return "Rp ${nominal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Aksi tombol unduh laporan
  void unduhPdf() {
    Get.snackbar(
      "Laporan PDF", 
      "Sedang mengunduh berkas laporan...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}