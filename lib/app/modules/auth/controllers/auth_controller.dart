import 'package:get/get.dart';

class AuthController extends GetxController {
  // 0: Splash, 1: Login, 2: Register
  var authStep = 0.obs;

  // Form State
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var isTermsAccepted = false.obs; // State baru untuk checkbox

  @override
  void onInit() {
    super.onInit();
    runSplashScreen();
  }

  // --- Navigasi Internal Modul Auth ---

  void runSplashScreen() async {
    // Memberi waktu user melihat logo (Splash Screen)
    await Future.delayed(const Duration(seconds: 3));
    authStep.value = 1; // Otomatis pindah ke Login
  }

  void goToRegister() {
    authStep.value = 2;
  }

  void goToLogin() {
    authStep.value = 1;
  }

  // --- Fungsi Aksi ---

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginProcess() async {
    isLoading.value = true;
    
    // Simulasi delay login (Bisa diganti dengan hit API Flask/Node.js Anda)
    await Future.delayed(const Duration(seconds: 2));
    
    isLoading.value = false;
    
    // Pindah ke Landing Page setelah login sukses
    // Menggunakan offAllNamed agar user tidak bisa 'Back' ke halaman login
    Get.offAllNamed('/home');
  }

  Future<void> registerProcess() async {
    isLoading.value = true;
    
    // Simulasi registrasi
    await Future.delayed(const Duration(seconds: 2));
    
    isLoading.value = false;
    
    // Setelah daftar, kembalikan ke login
    Get.snackbar("Sukses", "Akun Anda berhasil dibuat. Silakan login.");
    authStep.value = 1;
  }
}