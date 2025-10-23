import '../models/pesanan.dart';

class DataPesanan {
  static List<Pesanan> daftarPesanan = [
    Pesanan(
      id: 'HK-122938',
      namaUser: 'Nama User',
      jumlah: 10,
      total: 80000,
      tanggal: '27 September 2025',
      noHp: '081234567890',
      alamat: 'Samarinda',
      status: 'Dalam Perjalanan',
    ),
    Pesanan(
      id: 'HK-122939',
      namaUser: 'Nama User',
      jumlah: 10,
      total: 80000,
      tanggal: '27 September 2025',
      noHp: '081234567890',
      alamat: 'Samarinda',
      status: 'Dalam Perjalanan',
    ),
    Pesanan(
      id: 'HK-122940',
      namaUser: 'Nama User',
      jumlah: 10,
      total: 80000,
      tanggal: '27 September 2025',
      noHp: '081234567890',
      alamat: 'Samarinda',
      status: 'Dalam Perjalanan',
    ),
  ];

  static void tambahPesanan(Pesanan pesanan) {
    daftarPesanan.add(pesanan);
  }

  static void updateStatus(String id, String status) {
    final index = daftarPesanan.indexWhere((p) => p.id == id);
    if (index != -1) {
      daftarPesanan[index].status = status;
    }
  }
}