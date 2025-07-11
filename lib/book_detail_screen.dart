import 'package:flutter/material.dart'; // import material dart
import 'cart_screen.dart'; //import halaman screen
import 'cart_data.dart';// import cart dart

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book; // Data buku yang diterima dari halaman sebelumnya

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Mengambil informasi detail dari buku
    final volumeInfo = book['volumeInfo'];

    // Menyimpan judul buku, atau menggunakan default jika tidak tersedia
    final title = volumeInfo['title'] ?? 'Tanpa Judul';

    // Menyimpan nama penulis, jika ada lebih dari satu maka digabung dengan koma
    final authors = (volumeInfo['authors'] ?? ['Unknown']).join(', ');

    // Deskripsi buku, atau teks default jika tidak tersedia
    final description = volumeInfo['description'] ?? 'Tidak ada deskripsi.';

    // Rating buku, dikonversi ke double, jika tidak ada maka 0.0
    final rating = volumeInfo['averageRating']?.toDouble() ?? 0.0;

    // Link thumbnail gambar sampul buku, jika tidak ada maka string kosong
    final thumbnail = volumeInfo['imageLinks']?['thumbnail'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        backgroundColor: Colors.white, // Warna background putih
        elevation: 0, // Menghilangkan bayangan pada AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Navigasi kembali ke halaman sebelumnya
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.bookmark, color: Colors.red), // Icon bookmark di pojok kanan atas
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // Padding seluruh isi halaman
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun anak dari kiri
          children: [
            // Menampilkan gambar buku di tengah
            Center(
              child: thumbnail.isNotEmpty
                  ? Image.network(
                thumbnail,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  // Jika terjadi error saat mengambil gambar, gunakan gambar lokal
                  return Image.asset(
                    'assets/images/flutter.png',
                    height: 200,
                  );
                },
              )
                  : Image.asset('assets/images/flutter.png', height: 200), // Jika tidak ada thumbnail
            ),
            const SizedBox(height: 16), // Jarak antar elemen
            // Menampilkan judul buku dengan gaya tebal dan besar
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Menampilkan nama penulis dengan warna teks lebih lembut
            Text(
              authors,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            // Menampilkan rating buku dengan icon bintang
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(rating.toStringAsFixed(1)), // Rating dengan 1 angka di belakang koma
              ],
            ),
            const SizedBox(height: 16),
            // Dua tombol: beli buku dan pergi ke keranjang
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Mengecek apakah buku sudah ada di keranjang
                    final existingIndex = cartItems.indexWhere(
                            (item) => item['title'] == title);

                    if (existingIndex != -1) {
                      // Jika buku sudah ada, tambahkan jumlahnya
                      cartItems[existingIndex]['quantity'] += 1;
                    } else {
                      // Jika belum ada, tambahkan buku baru ke dalam keranjang
                      cartItems.add({
                        'title': title,
                        'thumbnail': thumbnail,
                        'quantity': 1,
                        'price': 52000, // Harga buku (bisa diubah sesuai data nyata)
                      });
                    }

                    // Arahkan ke halaman keranjang setelah menambahkan buku
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Warna tombol hijau kebiruan
                  ),
                  child: const Text('Beli Buku'),
                ),
                const SizedBox(width: 12),
                // Tombol untuk langsung membuka halaman keranjang
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Keranjang'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Judul bagian deskripsi
            const Text(
              'Deskripsi Buku',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Menampilkan deskripsi buku dalam scrollable area jika teks panjang
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
