import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan logo Biznary dari assets
            Image.asset(
              'assets/images/logo_biznary.png', // Sesuaikan dengan nama file asli kamu
              width: 150,  // Sesuaikan ukuran lebar logo
              height: 150, // Sesuaikan ukuran tinggi logo
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // const Text(
            //   "BIZNARY",
            //   style: TextStyle(
            //     fontSize: 24, 
            //     fontWeight: FontWeight.bold, 
            //     color: Color(0xFF1A56BE), // Menggunakan biru tema Biznary
            //     letterSpacing: 2.0,
            //   ),
            // ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A56BE)),
            ),
          ],
        ),
      ),
    );
  }
}