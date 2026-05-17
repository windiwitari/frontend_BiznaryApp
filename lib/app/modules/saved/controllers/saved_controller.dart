import 'package:get/get.dart';

class SavedController extends GetxController {
  // Data dummy sesuai desain
  var businessName = "SmartLogistics AI".obs;
  var category = "SaaS Platform".obs;
  var viabilityScore = 94.obs;
  var description = "An automated supply chain optimization tool using predictive analytics to reduce last-mile delivery costs by up to 22% for mid-sized retailers.".obs;
  var marketSize = "\$14.2B TAM".obs;
  var estRoi = "18 Months".obs;

  void simpanHasil() {
    Get.snackbar("Success", "Concept saved to your cloud dashboard");
  }

  void downloadPdf() {
    Get.snackbar("Download", "Preparing your pitch deck PDF...");
  }

  void shareConcept() {
    Get.snackbar("Share", "Opening share options...");
  }
}