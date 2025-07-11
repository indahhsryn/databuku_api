import 'package:flutter/material.dart'; // Mengimpor library dasar Material Design Flutter
import 'package:cloud_firestore/cloud_firestore.dart'; // Mengimpor library Firestore untuk database

class ReviewScreen extends StatefulWidget { // Mendefinisikan class ReviewScreen
  const ReviewScreen({super.key}); // Constructor dengan optional key parameter

  @override
  State<ReviewScreen> createState() => _ReviewScreenState(); // Membuat state untuk ReviewScreen
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _reviewController = TextEditingController(); // Controller untuk TextField

  // Fungsi untuk mengirim ulasan
  Future<void> _submitReview() async {
    final reviewText = _reviewController.text.trim(); // Mengambil teks ulasan dan menghapus spasi

    // Memeriksa apakah ulasan kosong
    if (reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ulasan tidak boleh kosong')), // Menampilkan pesan jika ulasan kosong
      );
      return; // Keluar dari fungsi
    }

    try {
      // Menambahkan ulasan ke koleksi 'reviews' di Firestore
      await FirebaseFirestore.instance.collection('reviews').add({
        'review': reviewText, // Menyimpan teks ulasan
        'timestamp': FieldValue.serverTimestamp(), // Menyimpan waktu saat ulasan dikirim
      });

      _reviewController.clear(); // Bersihkan field input
      FocusScope.of(context).unfocus(); // Tutup keyboard

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ulasan berhasil dikirim')), // Menampilkan pesan sukses
      );
    } catch (e) {
      // Menangani kesalahan saat mengirim ulasan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim ulasan: $e')), // Menampilkan pesan kesalahan
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        title: const Text('Ulasan Pengguna'), // Judul AppBar
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
        foregroundColor: Colors.white, // Warna teks AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk konten
        child: Column(
          children: [
            const Text(
              'Berikan Ulasanmu', // Judul untuk bagian ulasan
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Gaya teks
            ),
            const SizedBox(height: 12), // Jarak vertikal
            TextField(
              controller: _reviewController, // Menghubungkan controller dengan TextField
              maxLines: 5, // Maksimal 5 baris input
              style: const TextStyle(color: Colors.black), // Gaya teks input
              decoration: InputDecoration(
                hintText: 'Tulis ulasan di sini...', // Placeholder untuk input
                hintStyle: const TextStyle(color: Colors.black54), // Gaya placeholder
                filled: true, // Mengisi latar belakang
                fillColor: Colors.grey[200], // Warna latar belakang input
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Sudut melengkung border
                ),
              ),
            ),
            const SizedBox(height: 20), // Jarak vertikal
            ElevatedButton(
              onPressed: _submitReview, // Memanggil fungsi untuk mengirim ulasan
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Warna tombol biru
                foregroundColor: Colors.white, // Warna teks tombol putih
                minimumSize: const Size(double.infinity, 50), // Ukuran minimum tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Sudut melengkung tombol
                ),
              ),
              child: const Text('Kirim Ulasan'), // Teks tombol
            ),
            const SizedBox(height: 30), // Jarak vertikal
            const Divider(color: Colors.black45), // Garis pemisah
            const Align(
              alignment: Alignment.centerLeft, // Mengatur posisi teks ke kiri
              child: Text(
                'Ulasan Terbaru:', // Judul untuk bagian ulasan terbaru
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Gaya teks
              ),
            ),
            const SizedBox(height: 10), // Jarak vertikal
            Expanded(
              child: StreamBuilder<QuerySnapshot>( // Menggunakan StreamBuilder untuk mendengarkan perubahan data
                stream: FirebaseFirestore.instance
                    .collection('reviews') // Mengambil koleksi 'reviews'
                    .orderBy('timestamp', descending: true) // Mengurutkan berdasarkan timestamp terbaru
                    .snapshots(), // Mendapatkan snapshot data
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                      'Terjadi kesalahan', // Pesan jika terjadi kesalahan
                      style: TextStyle(color: Colors.black),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Menampilkan loading indicator
                  }

                  final docs = snapshot.data!.docs; // Mengambil dokumen dari snapshot

                  if (docs.isEmpty) {
                    return const Text(
                      'Belum ada ulasan.', // Pesan jika tidak ada ulasan
                      style: TextStyle(color: Colors.black54),
                    );
                  }

                  return ListView.builder(
                    itemCount: docs.length, // Jumlah ulasan
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>; // Mengambil data ulasan
                      final reviewText = data['review'] ?? ''; // Mengambil teks ulasan

                      return Card(
                        color: Colors.grey[100], // Warna latar belakang kartu
                        margin: const EdgeInsets.symmetric(vertical: 6), // Margin vertikal
                        child: ListTile(
                          title: Text(
                            reviewText, // Menampilkan teks ulasan
                            style: const TextStyle(color: Colors.black87), // Gaya teks ulasan
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}