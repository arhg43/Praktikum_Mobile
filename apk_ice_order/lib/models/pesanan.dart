class Pesanan {
  String id;
  String namaUser;
  int jumlah;
  double total;
  String tanggal;
  String noHp;
  String alamat;
  String status;

  Pesanan({
    required this.id,
    required this.namaUser,
    required this.jumlah,
    required this.total,
    required this.tanggal,
    required this.noHp,
    required this.alamat,
    this.status = 'Dalam Perjalanan',
  });
}
