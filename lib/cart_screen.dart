import 'package:flutter/material.dart';
import 'cart_data.dart'; // Mengimpor data keranjang
import 'transaction_success_screen.dart'; // Mengimpor layar sukses transaksi

class CartScreen extends StatefulWidget {
  const CartScreen({super.key}); // Konstruktor untuk CartScreen

  @override
  State<CartScreen> createState() => _CartScreenState(); // Membuat state untuk CartScreen
}

class _CartScreenState extends State<CartScreen> {
  // Fungsi untuk menambah jumlah item di keranjang
  void incrementQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++; // Menambah kuantitas item
    });
  }

  // Fungsi untuk mengurangi jumlah item di keranjang
  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--; // Mengurangi kuantitas item jika lebih dari 1
      }
    });
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index); // Menghapus item berdasarkan index
    });
  }

  // Fungsi untuk menghitung total harga setelah diskon
  int calculateTotal() {
    int totalBeforeDiscount = cartItems.fold(
      0,
          (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int), // Menghitung total harga sebelum diskon
    );
    int totalDiscount = 13000; // Diskon tetap
    return totalBeforeDiscount - totalDiscount; // Mengembalikan total setelah diskon
  }

  // Fungsi untuk membangun baris pembayaran
  Widget buildPaymentRow(String label, String amount,
      {bool isNegative = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label), // Label untuk baris pembayaran
          Text(
            amount, // Jumlah pembayaran
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal, // Menentukan ketebalan teks
              color: isNegative ? Colors.red : Colors.black, // Menentukan warna teks
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total harga sebelum diskon
    int totalBeforeDiscount = cartItems.fold(
      0,
          (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int),
    );
    int totalDiscount = 13000; // Diskon tetap
    int totalPrice = totalBeforeDiscount - totalDiscount; // Total harga setelah diskon

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'), // Judul aplikasi
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        foregroundColor: Colors.black, // Warna teks AppBar
        elevation: 0, // Menghilangkan bayangan
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Tombol kembali
          onPressed: () => Navigator.pop(context), // Kembali ke layar sebelumnya
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16), // Jarak vertikal
            ...cartItems.map((item) {
              final index = cartItems.indexOf(item); // Mendapatkan index item
              final subtotal = (item['price'] as int) * item['quantity']; // Menghitung subtotal
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12), // Border untuk item
                    borderRadius: BorderRadius.circular(12), // Sudut melengkung
                  ),
                  padding: const EdgeInsets.all(12), // Padding dalam item
                  child: Row(
                    children: [
                      item['thumbnail'] != ''
                          ? Image.network(
                        item['thumbnail'], // Gambar item dari URL
                        width: 70,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/flutter.png', // Gambar default jika gagal
                            width: 70,
                            height: 100,
                          );
                        },
                      )
                          : Image.asset(
                        'assets/images/flutter.png', // Gambar default
                        width: 70,
                        height: 100,
                      ),
                      const SizedBox(width: 12), // Jarak horizontal
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)), // Judul item
                            const SizedBox(height: 4),
                            const Text('Soft Cover - 1 Barang (0.2 kg)',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)), // Deskripsi item
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline), // Tombol untuk mengurangi kuantitas
                                  onPressed: () => decrementQuantity(index),
                                ),
                                Text(item['quantity'].toString()), // Menampilkan kuantitas
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline), // Tombol untuk menambah kuantitas
                                  onPressed: () => incrementQuantity(index),
                                ),
                                const Spacer(), // Mengisi ruang kosong
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.grey), // Tombol untuk menghapus item
                                  onPressed: () => removeItem(index),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text('Rp $subtotal'), // Menampilkan subtotal
                    ],
                  ),
                ),
              );
            }).toList(),

            const Divider(), // Garis pemisah
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ringkasan Pembayaran',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), // Judul ringkasan pembayaran
                  const SizedBox(height: 8),
                  buildPaymentRow('Total Harga', 'Rp $totalBeforeDiscount'), // Menampilkan total harga
                  buildPaymentRow('Total Biaya Pengiriman', 'Rp 0'), // Menampilkan biaya pengiriman
                  buildPaymentRow('Biaya Asuransi', 'Rp 0'), // Menampilkan biaya asuransi
                  buildPaymentRow('Diskon Belanja', '- Rp $totalDiscount',
                      isNegative: true), // Menampilkan diskon belanja
                  buildPaymentRow('Diskon Pengiriman', '- Rp 0', isNegative: true), // Menampilkan diskon pengiriman
                  buildPaymentRow('Potongan Kupon', '- Rp 0', isNegative: true), // Menampilkan potongan kupon
                  const Divider(), // Garis pemisah
                  buildPaymentRow('Total Dibayar', 'Rp $totalPrice',
                      isBold: true), // Menampilkan total yang harus dibayar
                  const SizedBox(height: 24),

                  const Text('Alamat Lengkap*',
                      style: TextStyle(fontWeight: FontWeight.bold)), // Judul alamat
                  const SizedBox(height: 6),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), // Border untuk TextField
                      hintText:
                      'No. 33 Jl. Lowanu 55162 Umbulharjo\nDaerah Istimewa Yogyakarta - < 1 km', // Placeholder
                    ),
                    maxLines: 2, // Maksimal 2 baris
                  ),
                  const SizedBox(height: 24),

                  const Text('Pilih Metode Pembayaran Kamu',
                      style: TextStyle(fontWeight: FontWeight.bold)), // Judul metode pembayaran
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700), // Warna latar belakang untuk metode pembayaran
                            borderRadius: BorderRadius.circular(10), // Sudut melengkung
                          ),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card), // Ikon kartu kredit
                              SizedBox(width: 8),
                              Text('Credit card'), // Teks untuk metode pembayaran
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200, // Warna latar belakang untuk metode pembayaran
                            borderRadius: BorderRadius.circular(10), // Sudut melengkung
                          ),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.money), // Ikon uang tunai
                              SizedBox(width: 8),
                              Text('Cash on delivery'), // Teks untuk metode pembayaran
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text('Nomor Kartu'), // Judul untuk nomor kartu
                  const SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '5261 4141 0151', // Placeholder untuk nomor kartu
                      suffixIcon: const Icon(Icons.credit_card), // Ikon di akhir TextField
                      filled: true,
                      fillColor: Colors.grey.shade200, // Warna latar belakang TextField
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)), // Border untuk TextField
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Cardholder name'), // Judul untuk nama pemegang kartu
                  const SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'aniaa', // Placeholder untuk nama pemegang kartu
                      filled: true,
                      fillColor: Colors.grey.shade200, // Warna latar belakang TextField
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)), // Border untuk TextField
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Expiry date'), // Judul untuk tanggal kedaluwarsa
                            const SizedBox(height: 6),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '03 / 2026', // Placeholder untuk tanggal kedaluwarsa
                                filled: true,
                                fillColor: Colors.grey.shade200, // Warna latar belakang TextField
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)), // Border untuk TextField
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('CVV / CVC'), // Judul untuk CVV/CVC
                            const SizedBox(height: 6),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '564', // Placeholder untuk CVV/CVC
                                filled: true,
                                fillColor: Colors.grey.shade200, // Warna latar belakang TextField
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)), // Border untuk TextField
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tombol Bayar
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionSuccessScreen(), // Navigasi ke layar sukses transaksi
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87, // Warna latar belakang tombol
                      minimumSize: const Size(double.infinity, 50), // Ukuran minimum tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Sudut melengkung tombol
                      ),
                    ),
                    child: const Text('Bayar'), // Teks tombol
                  ),

                  const SizedBox(height: 30), // Jarak vertikal
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}