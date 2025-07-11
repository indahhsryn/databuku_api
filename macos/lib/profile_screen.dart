import 'package:flutter/material.dart'; // Import library dasar Material Design Flutter

class ProfileScreen extends StatelessWidget { // Mendefinisikan class ProfileScreen
  const ProfileScreen({super.key}); // Constructor dengan optional key parameter

  @override
  Widget build(BuildContext context) { // Method build wajib untuk StatelessWidget
    return const Scaffold( // Scaffold sebagai struktur dasar layout material design
      backgroundColor: Colors.white, // Mengatur warna background scaffold menjadi putih
      body: Center( // Widget untuk menengahkan child-nya
        child: Text( // Widget untuk menampilkan teks
          'Ini halaman Profil', // Konten teks yang akan ditampilkan
          style: TextStyle(fontSize: 20), // Gaya teks dengan ukuran font 20
        ),
      ),
    );
  }
}