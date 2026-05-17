import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../core/widgets/biznary_button.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Latar belakang abu-abu muda
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

                      // --- MAIN CONTENT: Floating Card Register ---
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
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D212D),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Join thousands of entrepreneurs building the future with data-driven insights.",
                                style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
                              ),
                              const SizedBox(height: 28),

                              // --- FIELD 1: Full Name ---
                              const Text(
                                "Full Name",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "John Doe",
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                  filled: true,
                                  fillColor: const Color(0xFFFDFDFD),
                                  prefixIcon: const Icon(Icons.person_outline, color: Colors.black38, size: 20),
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

                              // --- FIELD 2: Email Address ---
                              const Text(
                                "Email Address",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "name@company.com",
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                  filled: true,
                                  fillColor: const Color(0xFFFDFDFD),
                                  prefixIcon: const Icon(Icons.mail_outline, color: Colors.black38, size: 20),
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

                              // --- FIELD 3: Password ---
                              const Text(
                                "Password",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Obx(() => TextField(
                                    obscureText: controller.isPasswordHidden.value,
                                    decoration: InputDecoration(
                                      hintText: "••••••••",
                                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                      filled: true,
                                      fillColor: const Color(0xFFFDFDFD),
                                      prefixIcon: const Icon(Icons.lock_open_outlined, color: Colors.black38, size: 20),
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
                                  )),
                              const SizedBox(height: 6),
                              const Text(
                                "Must be at least 8 characters long.",
                                style: TextStyle(color: Colors.black45, fontSize: 11),
                              ),
                              const SizedBox(height: 20),

                              // --- CHECKBOX: Terms & Conditions ---
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Obx(() => Checkbox(
                                          value: controller.isTermsAccepted.value,
                                          activeColor: const Color(0xFF1A56BE),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                          side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                                          onChanged: (value) {
                                            controller.isTermsAccepted.value = value ?? false;
                                          },
                                        )),
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.3),
                                        children: [
                                          TextSpan(
                                            text: "Terms and Conditions",
                                            style: TextStyle(color: Color(0xFF0084FF), fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(text: " and the "),
                                          TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(color: Color(0xFF0084FF), fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),

                              // --- BUTTON: Sign Up ---
                              BiznaryButton(
                                text: "Sign Up",
                                onPressed: () {
                                  // Logika pendaftaran akun
                                  controller.goToLogin();
                                },
                              ),
                              const SizedBox(height: 24),

                              // --- FOOTER CARD: Log In Route ---
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account? ",
                                    style: TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.goToLogin(),
                                    child: const Text(
                                      "Log in",
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

                      // --- BADGES: Secure Data & ISO Certified ---
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.gpp_good_outlined, size: 16, color: Colors.black45),
                          const SizedBox(width: 4),
                          const Text("Secure Data", style: TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 24),
                          Icon(Icons.cloud_done_outlined, size: 16, color: Colors.black45),
                          const SizedBox(width: 4),
                          const Text("ISO Certified", style: TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w500)),
                        ],
                      ),

                      const Spacer(),
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