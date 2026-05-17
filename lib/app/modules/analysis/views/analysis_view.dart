import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/analysis_controller.dart';

class AnalysisView extends GetView<AnalysisController> {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Grafik Progress Melingkar
              Obx(() => Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          value: controller.progress.value,
                          strokeWidth: 10,
                          backgroundColor: Colors.blue.shade50,
                          color: Colors.blue,
                        ),
                      ),
                      const Icon(Icons.analytics_outlined, size: 50, color: Colors.blue),
                    ],
                  )),
              const SizedBox(height: 40),
              const Text(
                "Memproses Analisis",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Mesin kami sedang mengevaluasi data pasar secara real-time.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              
              // List Item Progress
              _buildProgressItem("Menganalisis lokasi...", controller.isLocationDone),
              _buildProgressItem("Menghitung peluang usaha...", controller.isMarketDone),
              _buildProgressItem("Menentukan rekomendasi...", controller.isRecommendationDone),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressItem(String title, RxBool isDone) {
    return Obx(() => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isDone.value ? Icons.check_circle : Icons.circle_outlined,
                color: isDone.value ? Colors.blue : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isDone.value ? Colors.black : Colors.grey,
                  fontWeight: isDone.value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isDone.value) const Text("100%", style: TextStyle(color: Colors.blue)),
            ],
          ),
        ));
  }
}