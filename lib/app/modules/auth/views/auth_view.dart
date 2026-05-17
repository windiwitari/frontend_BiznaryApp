import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'splash_view.dart';
import 'login_view.dart';
import 'register_view.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Obx akan memantau perubahan authStep secara reaktif
      body: Obx(() {
        switch (controller.authStep.value) {
          case 0:
            return const SplashView();
          case 1:
            return const LoginView();
          case 2:
            return const RegisterView();
          default:
            return const LoginView();
        }
      }),
    );
  }
}