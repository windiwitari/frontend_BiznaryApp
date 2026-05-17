import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Menambahkan tombol Close di kiri
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54),
          onPressed: () => Get.back(), // Kembali ke halaman sebelumnya
        ),
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
            const Text("Laporan Rencana\nAnggaran Biaya", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1D212D))),
            const SizedBox(height: 30),
            
            _buildSectionHeader(Icons.account_balance_wallet_outlined, "Modal Awal"),
            _buildModalCard(),
            
            const SizedBox(height: 30),
            
            _buildSectionHeader(Icons.domain_outlined, "Biaya Produk"),
            _buildRabTable(),
            
            const SizedBox(height: 30),
            
            _buildSummaryCard(),
            
            const SizedBox(height: 30),
            
            // --- Group Tombol Aksi ---
            Column(
              children: [
                // Tombol Unduh PDF
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0084FF),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    onPressed: () => controller.unduhPdf(),
                    child: const Text("Unduh PDF", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Tombol Analisis Ulang
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0084FF)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Get.offAllNamed('/map-picker'), // Menghapus stack navigasi dan kembali ke Map
                    child: const Text("Analisis Ulang", 
                        style: TextStyle(color: Color(0xFF0084FF), fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ... Widget pendukung lainnya (_buildSectionHeader, _buildModalCard, dll tetap sama)
  
  Widget _buildSectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1A56BE), size: 20),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A56BE))),
        ],
      ),
    );
  }

  Widget _buildModalCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Obx(() => Text(
              controller.formatRupiah(controller.totalModal.value), 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A56BE))
            )),
          ),
          Obx(() => _buildInfoRow("Kategori Usaha", controller.kategoriUsaha.value)),
          Obx(() => _buildInfoRow("Rekomendasi Usaha", controller.rekomendasiUsaha.value, isLast: true)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.blue.shade100),
          bottom: isLast ? BorderSide.none : BorderSide(color: Colors.blue.shade100),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A56BE))),
              Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRabTable() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Obx(() => Table(
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(1.2),
          2: FlexColumnWidth(1.1),
        },
        border: TableBorder.symmetric(inside: BorderSide(color: Colors.grey.shade300)),
        children: [
          _buildTableHeader(),
          ...controller.listRab.map((item) => _buildTableRow(
            item['komponen']!, 
            item['detail']!, 
            controller.formatRupiah(int.parse(item['biaya']!))
          )).toList(),
          _buildTableFooter(),
        ],
      )),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      children: ["Komponen", "Detail", "Estimasi Biaya"].map((text) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54)),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(String col1, String col2, String col3) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(12), child: Text(col1, style: const TextStyle(fontSize: 12))),
        Padding(padding: const EdgeInsets.all(12), child: Text(col2, style: const TextStyle(fontSize: 12, color: Colors.black54))),
        Padding(padding: const EdgeInsets.all(12), child: Text(col3, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
      ],
    );
  }

  TableRow _buildTableFooter() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.02)),
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text("TOTAL ESTIMASI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1A56BE))),
        ),
        const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(controller.formatRupiah(controller.totalEstimasi), 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1A56BE))),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0D61C9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("RINGKASAN RAB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1, fontSize: 12)),
          const SizedBox(height: 16),
          const Text("TOTAL MODAL", style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(controller.formatRupiah(controller.totalModal.value), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: Colors.white24, height: 30),
          const Text("SISA DANA CADANGAN", style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(controller.formatRupiah(controller.sisaDana), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      )),
    );
  }
}