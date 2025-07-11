import 'package:flutter/material.dart'; // Mengimpor library dasar Material Design Flutter
import 'review_screen.dart'; // Mengimpor ReviewScreen untuk navigasi

class TransactionSuccessScreen extends StatelessWidget { // Mendefinisikan class TransactionSuccessScreen
  const TransactionSuccessScreen({super.key}); // Constructor dengan optional key parameter

  @override
  Widget build(BuildContext context) { // Method build wajib untuk StatelessWidget
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      body: Center( // Menggunakan Center agar semua konten berada di tengah
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Padding untuk konten
          child: Column(
            mainAxisSize: MainAxisSize.min, // Mengatur ukuran kolom agar sesuai dengan konten
            children: [
              const Icon(Icons.check_circle, size: 70, color: Colors.greenAccent), // Ikon centang untuk menunjukkan keberhasilan
              const SizedBox(height: 24), // Jarak vertikal
              const Text(
                'Yeayy!!', // Teks untuk menyatakan keberhasilan
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Gaya teks
              ),
              const SizedBox(height: 8), // Jarak vertikal
              const Text(
                'Transaksimu berhasil', // Teks untuk menjelaskan bahwa transaksi berhasil
                style: TextStyle(fontSize: 16), // Gaya teks
              ),
              const SizedBox(height: 40), // Jarak vertikal
              ElevatedButton(
                onPressed: () { // Fungsi yang dipanggil saat tombol ditekan
                  Navigator.push( // Navigasi ke layar baru
                    context,
                    MaterialPageRoute(builder: (context) => const ReviewScreen()), // Mengarahkan ke ReviewScreen
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87, // Warna latar belakang tombol
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14), // Padding dalam tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Sudut melengkung tombol
                  ),
                ),
                child: const Text(
                  'Tambah Ulasan', // Teks tombol
                  style: TextStyle(color: Colors.white, fontSize: 16), // Gaya teks tombol
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}