import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/saved_controller.dart';

class SavedView extends GetView<SavedController> {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Biznary", 
            style: TextStyle(color: Color(0xFF1A56BE), fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
                backgroundColor: Colors.grey.shade200, 
                child: const Icon(Icons.person_outline, color: Colors.blue)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("READY TO LAUNCH", 
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A56BE), letterSpacing: 1.1)),
            const SizedBox(height: 4),
            const Text("Export Your Concept", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1D212D))),
            const SizedBox(height: 24),
            
            // --- Concept Preview Card ---
            _buildConceptCard(),
            
            const SizedBox(height: 24),
            
            // --- Action Buttons ---
            _buildActionButton(
              title: "Simpan Hasil",
              subtitle: "Save to your cloud dashboard",
              icon: Icons.cloud_upload_outlined,
              color: const Color(0xFF0056D2),
              isPrimary: true,
              onTap: () => controller.simpanHasil(),
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              title: "Download PDF",
              subtitle: "Full investor-ready pitch deck",
              icon: Icons.picture_as_pdf_outlined,
              color: const Color(0xFFD6E4FF),
              onTap: () => controller.downloadPdf(),
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              title: "Share",
              subtitle: "Send via email or link",
              icon: Icons.share_outlined,
              color: Colors.white,
              borderColor: Colors.grey.shade300,
              onTap: () => controller.shareConcept(),
            ),
            
            const SizedBox(height: 20),
            
            // --- Premium Info Box ---
            _buildPremiumInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD6E4FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFD6E4FF), borderRadius: BorderRadius.circular(20)),
                child: Obx(() => Text(controller.category.value, style: const TextStyle(color: Color(0xFF0056D2), fontSize: 12, fontWeight: FontWeight.bold))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Viability Score", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Obx(() => Text("${controller.viabilityScore.value}/100", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0056D2)))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() => Text(controller.businessName.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          Obx(() => Text(controller.description.value, style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5))),
          const Divider(height: 32),
          Row(
            children: [
              _buildMiniInfo("Market Size", controller.marketSize), // Hapus .value
                const Spacer(),
              _buildMiniInfo("Est. ROI", controller.estRoi), // Hapus .valueconst Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniInfo(String label, RxString value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Obx(() => Text(value.value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildActionButton({required String title, required String subtitle, required IconData icon, required Color color, Color? borderColor, bool isPrimary = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: borderColor != null ? Border.all(color: borderColor) : null,
          boxShadow: isPrimary ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: isPrimary ? Colors.white24 : Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: isPrimary ? Colors.white : const Color(0xFF0056D2)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isPrimary ? Colors.white : Colors.black87)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: isPrimary ? Colors.white70 : Colors.black54)),
                ],
              ),
            ),
            Icon(isPrimary ? Icons.chevron_right : Icons.download, color: isPrimary ? Colors.white : const Color(0xFF0056D2)),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFEDF3FF), borderRadius: BorderRadius.circular(12)),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFF0056D2)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Premium members can export unlimited concepts in high-resolution vector formats.",
              style: TextStyle(fontSize: 12, color: Color(0xFF0056D2)),
            ),
          ),
        ],
      ),
    );
  }
}