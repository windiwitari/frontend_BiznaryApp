import 'package:get/get.dart';

class AnalysisController extends GetxController {
  // Observables untuk memantau progress
  var progress = 0.0.obs;
  var currentTask = "Menganalisis lokasi...".obs;
  var isLocationDone = false.obs;
  var isMarketDone = false.obs;
  var isRecommendationDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    runAnalysisSimulation();
  }

  void runAnalysisSimulation() async {
    // Tahap 1: Lokasi
    await Future.delayed(const Duration(seconds: 1));
    isLocationDone.value = true;
    progress.value = 0.3;
    currentTask.value = "Menghitung peluang usaha...";

    // Tahap 2: Peluang Pasar
    await Future.delayed(const Duration(seconds: 2));
    isMarketDone.value = true;
    progress.value = 0.7;
    currentTask.value = "Menentukan rekomendasi...";

    // Tahap 3: Finalisasi
    await Future.delayed(const Duration(seconds: 1));
    isRecommendationDone.value = true;
    progress.value = 1.0;

    // Jeda sebentar sebelum pindah ke halaman hasil
    await Future.delayed(const Duration(milliseconds: 500));
    Get.offNamed('/result');
  }
}