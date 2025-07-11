import 'package:flutter/material.dart'; // Mengimpor library dasar Material Design Flutter

class RegisterScreen extends StatelessWidget { // Mendefinisikan class RegisterScreen
  const RegisterScreen({super.key}); // Constructor dengan optional key parameter

  @override
  Widget build(BuildContext context) { // Method build wajib untuk StatelessWidget
    return Scaffold( // Scaffold sebagai struktur dasar layout material design
      body: SafeArea( // Menghindari area yang terhalang oleh status bar dan notifikasi
        child: SingleChildScrollView( // Memungkinkan scroll jika konten melebihi layar
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Padding untuk konten
          child: Column( // Kolom untuk menampung widget secara vertikal
            children: [
              // Bagian gambar scroll horizontal
              SizedBox(
                height: 140, // Tinggi untuk gambar
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Mengatur scroll horizontal
                  itemCount: 8, // Jumlah gambar
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6), // Jarak horizontal antar gambar
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Sudut melengkung untuk gambar
                        child: Image.asset(
                          'assets/images/gambar${(index % 9) + 1}.png', // Mengambil gambar dari assets
                          width: 80, // Lebar gambar
                          height: 120, // Tinggi gambar
                          fit: BoxFit.cover, // Mengatur cara gambar ditampilkan
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24), // Jarak vertikal
              const Text(
                'DAFTAR', // Judul untuk layar pendaftaran
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1), // Gaya teks
              ),

              const SizedBox(height: 24), // Jarak vertikal

              // Input nama
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nama lengkap', // Placeholder untuk input nama
                  border: OutlineInputBorder(), // Border untuk TextField
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Padding dalam TextField
                ),
              ),
              const SizedBox(height: 16), // Jarak vertikal

              // Input email
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email', // Placeholder untuk input email
                  border: OutlineInputBorder(), // Border untuk TextField
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Padding dalam TextField
                ),
              ),
              const SizedBox(height: 16), // Jarak vertikal

              // Input password
              const TextField(
                obscureText: true, // Menyembunyikan teks untuk password
                decoration: InputDecoration(
                  hintText: 'Kata Sandi', // Placeholder untuk input password
                  suffixIcon: Icon(Icons.visibility), // Ikon untuk menunjukkan visibilitas password
                  border: OutlineInputBorder(), // Border untuk TextField
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Padding dalam TextField
                ),
              ),

              const SizedBox(height: 8), // Jarak vertikal
              Align(
                alignment: Alignment.centerRight, // Mengatur posisi teks ke kanan
                child: Text(
                  "Lupa Kata Sandi?", // Teks untuk lupa password
                  style: TextStyle(fontSize: 12, color: Colors.grey), // Gaya teks
                ),
              ),

              const SizedBox(height: 24), // Jarak vertikal
              // Tombol Daftar
              SizedBox(
                width: double.infinity, // Lebar tombol penuh
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan aksi sign up di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6D365), // Warna kuning muda
                    foregroundColor: Colors.black, // Warna teks tombol
                    padding: const EdgeInsets.symmetric(vertical: 14), // Padding dalam tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Sudut melengkung tombol
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600), // Gaya teks tombol
                  ),
                  child: const Text("Sign Up"), // Teks tombol
                ),
              ),

              const SizedBox(height: 24), // Jarak vertikal
              const DividerWithText(text: "atau"), // Pemisah dengan teks

              const SizedBox(height: 20), // Jarak vertikal
              // Social login
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Mengatur jarak antar ikon
                children: [
                  socialLoginIcon(Icons.facebook, Colors.blue), // Ikon Facebook
                  socialLoginIcon(Icons.g_mobiledata_rounded, Colors.red), // Ikon Google
                  socialLoginIcon(Icons.apple, Colors.black), // Ikon Apple
                ],
              ),

              const SizedBox(height: 24), // Jarak vertikal
              // Teks login
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi ke tengah
                children: [
                  Text("Sudah punya akun?", style: TextStyle(color: Colors.grey[700])), // Teks untuk pendaftaran
                  const SizedBox(width: 4), // Jarak horizontal
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Kembali ke login
                    },
                    child: const Text("Login", style: TextStyle(color: Color(0xFFF6D365))), // Teks untuk login
                  ),
                ],
              ),
              const SizedBox(height: 12), // Jarak vertikal
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat ikon login sosial
  static Widget socialLoginIcon(IconData icon, Color color) {
    return Container(
      width: 48, // Lebar ikon
      height: 48, // Tinggi ikon
      padding: const EdgeInsets.all(10), // Padding dalam ikon
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300), // Border untuk ikon
        borderRadius: BorderRadius.circular(12), // Sudut melengkung
      ),
      child: Icon(icon, color: color), // Menampilkan ikon
    );
  }
}

// Kelas untuk membuat pemisah dengan teks di tengah
class DividerWithText extends StatelessWidget {
  final String text; // Teks yang akan ditampilkan
  const DividerWithText({super.key, required this.text}); // Konstruktor

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)), // Garis pemisah kiri
        const SizedBox(width: 8), // Jarak horizontal
        Text(text, style: const TextStyle(color: Colors.grey)), // Teks di tengah
        const SizedBox(width: 8), // Jarak horizontal
        const Expanded(child: Divider(thickness: 1)), // Garis pemisah kanan
      ],
    );
  }
}