import 'package:biznary/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../core/widgets/biznary_button.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Latar belakang abu-abu sangat muda halus
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // --- HEADER: Title App Biznary ---
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Biznary",
                          style: TextStyle(
                            color: Color(0xFF1A56BE),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      
                      const Spacer(),

                      // --- MAIN CONTENT: Floating Card Login ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1A56BE).withOpacity(0.06),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D212D),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Enter your credentials to access your dashboard.",
                                style: TextStyle(color: Colors.black54, fontSize: 13),
                              ),
                              const SizedBox(height: 28),

                              // --- FIELD 1: Email Address ---
                              const Text(
                                "Email Address",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "name@company.com",
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                  filled: true,
                                  fillColor: const Color(0xFFFDFDFD),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // --- FIELD 2: Password & Forgot Password ---
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Logika Lupa Password
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0084FF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Obx(() => TextField(
                                    obscureText: controller.isPasswordHidden.value,
                                    decoration: InputDecoration(
                                      hintText: "••••••••",
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                      filled: true,
                                      fillColor: const Color(0xFFFDFDFD),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Colors.black54,
                                          size: 20,
                                        ),
                                        onPressed: () => controller.isPasswordHidden.toggle(),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 28),

                              // --- BUTTON: Login Button ---
                              BiznaryButton(
                                text: "Login",
                                onPressed: () => Get.offAllNamed(Routes.DASHBOARD),
                              ),
                              const SizedBox(height: 24),

                              // --- FOOTER CARD: Sign Up ---
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "New to Biznary? ",
                                    style: TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.goToRegister(),
                                    child: const Text(
                                      "Create an account",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0084FF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // --- FOOTER: Copyright ---
                      const Padding(
                        padding: EdgeInsets.only(bottom: 24, top: 16),
                        child: Text(
                          "© 2026 Biznary Company. Secure professional intelligence.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}