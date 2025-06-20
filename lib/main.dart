import 'package:flutter/material.dart'; // Mengimpor paket material untuk menggunakan widget Flutter
import 'package:http/http.dart' as http; // Mengimpor paket http untuk melakukan permintaan HTTP
import 'dart:convert'; // Mengimpor pustaka untuk mengonversi data JSON
import 'package:url_launcher/url_launcher.dart'; // Mengimpor paket untuk membuka URL di browser

void main() => runApp(const MyApp()); // Fungsi utama untuk menjalankan aplikasi

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor untuk MyApp

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      home: SplashScreen(), // Menetapkan SplashScreen sebagai halaman awal
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key}); // Konstruktor untuk SplashScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16), // Jarak atas
              Row(
                children: const [
                  SizedBox(width: 16), // Jarak kiri
                  Icon(Icons.menu_book, size: 28), // Ikon buku
                  SizedBox(width: 8), // Jarak antara ikon dan teks
                  Text("Ibubuku",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Teks judul
                ],
              ),
              const SizedBox(height: 20), // Jarak bawah
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12), // Padding horizontal
                child: Wrap(
                  spacing: 8, // Jarak antar item
                  runSpacing: 8, // Jarak antar baris
                  alignment: WrapAlignment.center, // Penempatan item di tengah
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 100, // Lebar gambar
                      height: 150, // Tinggi gambar
                      child: Image.asset(
                        'assets/images/gambar${(index % 9) + 1}.png', // Mengambil gambar dari aset
                        width: 80, // Lebar gambar
                        height: 120, // Tinggi gambar
                        fit: BoxFit.cover, // Memastikan gambar menutupi area
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 32), // Jarak bawah
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), // Padding horizontal
                child: Text(
                  'Dengan Flutter, Ide Anda Bisa Menjadi Aplikasi Nyata', // Teks slogan
                  textAlign: TextAlign.center, // Penempatan teks di tengah
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Gaya teks
                ),
              ),
              const SizedBox(height: 12), // Jarak bawah
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24), // Padding horizontal
                child: Text(
                  'Flutter bukan hanya framework, tapi jembatan untuk mengubah ide menjadi aplikasi yang nyata. Dengan belajar Flutter, kamu membuka peluang untuk menciptakan solusi digital yang indah dan efisien.', // Deskripsi tentang Flutter
                  textAlign: TextAlign.center, // Penempatan teks di tengah
                  style: TextStyle(color: Colors.black54), // Gaya teks
                ),
              ),
              const SizedBox(height: 24), // Jarak bawah
              Padding(
                padding: const EdgeInsets.only(bottom: 30), // Padding bawah
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const BookApp()), // Navigasi ke BookApp
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, // Warna latar belakang tombol
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Padding tombol
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)), // Bentuk tombol
                  ),
                  child: const Text("Mulai Sekarang", // Teks tombol
                      style: TextStyle(color: Colors.white)), // Gaya teks tombol
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BookApp extends StatelessWidget {
  const BookApp({super.key}); // Konstruktor untuk BookApp

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      home: HomeScreen(), // Menetapkan HomeScreen sebagai halaman utama
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // Konstruktor untuk HomeScreen

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Mengembalikan state untuk HomeScreen
}

class _HomeScreenState extends State<HomeScreen> {
  List books = []; // Daftar buku
  List filteredBooks = []; // Daftar buku yang difilter
  TextEditingController searchController = TextEditingController(); // Kontroler untuk pencarian

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Memanggil fungsi untuk mengambil data buku
  }

  Future<void> fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter')); // Mengambil data buku dari API
    if (response.statusCode == 200) { // Jika permintaan berhasil
      final data = json.decode(response.body); // Mengonversi data JSON
      setState(() {
        books = data['items']; // Menyimpan data buku
        filteredBooks = books; // Menyimpan buku yang difilter
      });
    }
  }

  String shortDescription(String? text) {
    if (text == null) return ''; // Mengembalikan string kosong jika teks null
    List words = text.split(' '); // Memecah teks menjadi kata
    return words.length > 10 ? '${words.sublist(0, 10).join(' ')}...' : text; // Mengembalikan deskripsi singkat
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() => filteredBooks = books); // Menampilkan semua buku jika query kosong
    } else {
      setState(() {
        filteredBooks = books.where((book) {
          final title = book['volumeInfo']['title'] ?? ''; // Mengambil judul buku
          return title.toLowerCase().contains(query.toLowerCase()); // Memfilter buku berdasarkan judul
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Mengambil lebar layar

    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Indeks item yang dipilih
        selectedItemColor: Colors.teal, // Warna item yang dipilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        showUnselectedLabels: true, // Menampilkan label item yang tidak dipilih
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'), // Item Beranda
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorit'), // Item Favorit
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'), // Item Dashboard
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'), // Item Profil
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Penempatan kolom di kiri
          children: [
            Container(
              padding: const EdgeInsets.all(16), // Padding untuk kontainer
              color: const Color(0xFF12455F), // Warna latar belakang kontainer
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'), // Gambar profil
                  ),
                  const SizedBox(width: 10), // Jarak antara gambar dan teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Penempatan teks di kiri
                      children: const [
                        Text('Selamat datang', style: TextStyle(color: Colors.white)), // Teks sambutan
                        Text('Indah Suryaningsih\nindah@gmail.com',
                            style: TextStyle(color: Colors.white70, fontSize: 12)), // Teks informasi pengguna
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {}, // Fungsi ketika tombol ditekan
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white), // Gaya tombol
                    child: const Text('Kunjungi profil',
                        style: TextStyle(color: Colors.black)), // Teks tombol
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10), // Padding untuk TextField
              child: TextField(
                controller: searchController, // Menghubungkan kontroler
                onChanged: filterSearch, // Memanggil fungsi filter saat teks berubah
                decoration: InputDecoration(
                  hintText: 'Cari buku...', // Teks petunjuk
                  prefixIcon: const Icon(Icons.search), // Ikon pencarian
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Bentuk border
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10), // Padding untuk judul produk
              child: Text('Produk Flutter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Judul produk
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // Padding untuk GridView
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300, // Lebar maksimum item
                  crossAxisSpacing: 12, // Jarak horizontal antar item
                  mainAxisSpacing: 12, // Jarak vertikal antar item
                  childAspectRatio: 0.65, // Rasio aspek item
                ),
                itemCount: filteredBooks.length, // Jumlah item yang ditampilkan
                itemBuilder: (context, index) {
                  final book = filteredBooks[index]['volumeInfo']; // Mengambil informasi buku
                  final title = book['title'] ?? ''; // Mengambil judul buku
                  final author = book['authors']?.join(', ') ?? 'Unknown'; // Mengambil penulis buku
                  final desc = shortDescription(book['description'] ?? ''); // Mengambil deskripsi singkat
                  final link = book['previewLink'] ?? ''; // Mengambil link pratinjau

                  return GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(link); // Mengonversi link menjadi URI
                      if (await canLaunchUrl(uri)) { // Memeriksa apakah URI dapat diluncurkan
                        await launchUrl(uri); // Meluncurkan URI
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50], // Warna latar belakang item
                        borderRadius: BorderRadius.circular(16), // Bentuk border item
                      ),
                      padding: const EdgeInsets.all(10), // Padding untuk item
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Penempatan kolom di kiri
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8), // Bentuk gambar
                              child: Image.asset(
                                'assets/images/gambar${(index % 9) + 1}.png', // Mengambil gambar dari aset
                                width: 100, // Lebar gambar
                                height: 120, // Tinggi gambar
                                fit: BoxFit.cover, // Memastikan gambar menutupi area
                              ),
                            ),
                          ),
                          const SizedBox(height: 8), // Jarak bawah
                          Text(
                            title,
                            maxLines: 2, // Maksimal baris judul
                            overflow: TextOverflow.ellipsis, // Memotong teks jika terlalu panjang
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14), // Gaya teks judul
                          ),
                          const SizedBox(height: 4), // Jarak bawah
                          Text(
                            author,
                            maxLines: 1, // Maksimal baris penulis
                            overflow: TextOverflow.ellipsis, // Memotong teks jika terlalu panjang
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black87), // Gaya teks penulis
                          ),
                          const SizedBox(height: 4), // Jarak bawah
                          Expanded(
                            child: Text(
                              desc,
                              maxLines: 3, // Maksimal baris deskripsi
                              overflow: TextOverflow.ellipsis, // Memotong teks jika terlalu panjang
                              style: const TextStyle(fontSize: 12), // Gaya teks deskripsi
                            ),
                          ),
                        ],
                      ),
                    ),
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