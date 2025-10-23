import 'package:flutter/material.dart';
import '../../models/pesanan.dart';
import '../../data/data_pesanan.dart';

class DetailProdukPage extends StatefulWidget {
  final String username;
  final String region;
  const DetailProdukPage({Key? key, required this.username, required this.region})
      : super(key: key);

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  int jumlah = 1;
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  void pesan() {
    if (noHpController.text.isEmpty || alamatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nomor HP dan Alamat harus diisi')),
      );
      return;
    }

    final pesanan = Pesanan(
      id: 'HK-${DateTime.now().millisecondsSinceEpoch}',
      namaUser: widget.username,
      jumlah: jumlah,
      total: jumlah * 8000.0,
      tanggal: '${DateTime.now().day} ${_getBulan(DateTime.now().month)} ${DateTime.now().year}',
      noHp: noHpController.text,
      alamat: alamatController.text,
    );

    DataPesanan.tambahPesanan(pesanan);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pesanan berhasil dibuat!')),
    );

    Navigator.pop(context);
  }

  String _getBulan(int bulan) {
    const bulanList = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return bulanList[bulan];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: const Color(0xFFB3E5E5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.ac_unit, size: 100, color: Colors.cyan),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Es Batu Kristal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'RP 8.000 / balok',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            const Text(
              'Jumlah',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (jumlah > 1) jumlah--;
                    });
                  },
                  icon: const Icon(Icons.remove_circle_outline, size: 30),
                ),
                Text(
                  '$jumlah',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      jumlah++;
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: noHpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Nomor HP',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: alamatController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Alamat Lengkap',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total: Rp ${jumlah * 8000}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pesan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF87CEEB),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}