import 'package:get/get.dart';

import '../controllers/business_form_controller.dart';

class BusinessFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessFormController>(
      () => BusinessFormController(),
    );
  }
}
