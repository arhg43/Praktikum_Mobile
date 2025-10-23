import 'package:flutter/material.dart';
import '../../data/data_pesanan.dart';
import '../auth/login_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFFB3E5E5),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF87CEEB),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.admin_panel_settings, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Admin Panel',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: currentIndex == 0,
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Kelola Pesanan'),
              selected: currentIndex == 1,
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Laporan'),
              selected: currentIndex == 2,
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    switch (currentIndex) {
      case 0:
        return const AdminDashboardView();
      case 1:
        return const AdminKelolaPesananView();
      case 2:
        return const AdminLaporanView();
      default:
        return const AdminDashboardView();
    }
  }
}

// Dashboard View
class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // GridView untuk statistik
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildStatCard(
                'Total Pesanan',
                DataPesanan.daftarPesanan.length.toString(),
                Icons.shopping_cart,
                Colors.blue,
              ),
              _buildStatCard(
                'Dalam Proses',
                DataPesanan.daftarPesanan
                    .where((p) => p.status == 'Dalam Perjalanan')
                    .length
                    .toString(),
                Icons.pending,
                Colors.orange,
              ),
              _buildStatCard(
                'Selesai',
                DataPesanan.daftarPesanan
                    .where((p) => p.status == 'Selesai')
                    .length
                    .toString(),
                Icons.check_circle,
                Colors.green,
              ),
              _buildStatCard(
                'Dibatalkan',
                DataPesanan.daftarPesanan
                    .where((p) => p.status == 'Dibatalkan')
                    .length
                    .toString(),
                Icons.cancel,
                Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Pesanan Terbaru',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          // ListView untuk pesanan terbaru
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: DataPesanan.daftarPesanan.length > 5 
                ? 5 
                : DataPesanan.daftarPesanan.length,
            itemBuilder: (context, index) {
              final pesanan = DataPesanan.daftarPesanan[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF87CEEB),
                    child: Text(pesanan.jumlah.toString()),
                  ),
                  title: Text('ID: ${pesanan.id}'),
                  subtitle: Text(pesanan.namaUser),
                  trailing: Chip(
                    label: Text(pesanan.status),
                    backgroundColor: _getStatusColor(pesanan.status),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green.shade100;
      case 'Dalam Perjalanan':
        return Colors.orange.shade100;
      case 'Dibatalkan':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}

// Kelola Pesanan View
class AdminKelolaPesananView extends StatefulWidget {
  const AdminKelolaPesananView({Key? key}) : super(key: key);

  @override
  State<AdminKelolaPesananView> createState() => _AdminKelolaPesananViewState();
}

class _AdminKelolaPesananViewState extends State<AdminKelolaPesananView> {
  String filterStatus = 'Semua';

  void _showDetailPesanan(int index) {
    final pesanan = DataPesanan.daftarPesanan[index];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Pesanan ${pesanan.id}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Nama', pesanan.namaUser),
              _buildDetailRow('Jumlah', '${pesanan.jumlah} balok'),
              _buildDetailRow('Total', 'Rp ${pesanan.total.toStringAsFixed(0)}'),
              _buildDetailRow('No HP', pesanan.noHp),
              _buildDetailRow('Alamat', pesanan.alamat),
              _buildDetailRow('Tanggal', pesanan.tanggal),
              _buildDetailRow('Status', pesanan.status),
              const SizedBox(height: 20),
              const Text(
                'Ubah Status:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildStatusButton('Dalam Perjalanan', pesanan.id),
              _buildStatusButton('Selesai', pesanan.id),
              _buildStatusButton('Dibatalkan', pesanan.id),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String status, String pesananId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            DataPesanan.updateStatus(pesananId, status);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Status diubah menjadi $status')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _getStatusButtonColor(status),
        ),
        child: Text(status),
      ),
    );
  }

  Color _getStatusButtonColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Dalam Perjalanan':
        return Colors.orange;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPesanan = filterStatus == 'Semua'
        ? DataPesanan.daftarPesanan
        : DataPesanan.daftarPesanan.where((p) => p.status == filterStatus).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              const Text('Filter: '),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Semua'),
                      _buildFilterChip('Dalam Perjalanan'),
                      _buildFilterChip('Selesai'),
                      _buildFilterChip('Dibatalkan'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredPesanan.length,
            itemBuilder: (context, index) {
              final pesanan = filteredPesanan[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF87CEEB),
                    child: Text(pesanan.jumlah.toString()),
                  ),
                  title: Text('ID: ${pesanan.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pesanan.namaUser),
                      Text('No HP: ${pesanan.noHp}'),
                      Text('Alamat: ${pesanan.alamat}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(pesanan.status),
                    backgroundColor: _getStatusColor(pesanan.status),
                  ),
                  onTap: () => _showDetailPesanan(
                    DataPesanan.daftarPesanan.indexOf(pesanan),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: filterStatus == label,
        onSelected: (selected) {
          setState(() {
            filterStatus = label;
          });
        },
        selectedColor: const Color(0xFF87CEEB),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green.shade100;
      case 'Dalam Perjalanan':
        return Colors.orange.shade100;
      case 'Dibatalkan':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}

// Laporan View
class AdminLaporanView extends StatefulWidget {
  const AdminLaporanView({Key? key}) : super(key: key);

  @override
  State<AdminLaporanView> createState() => _AdminLaporanViewState();
}

class _AdminLaporanViewState extends State<AdminLaporanView> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    final totalPendapatan = DataPesanan.daftarPesanan
        .where((p) => p.status == 'Selesai')
        .fold(0.0, (sum, p) => sum + p.total);
    
    final totalBalok = DataPesanan.daftarPesanan
        .where((p) => p.status == 'Selesai')
        .fold(0, (sum, p) => sum + p.jumlah);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Laporan Penjualan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Switch untuk show details
          SwitchListTile(
            title: const Text('Tampilkan Detail'),
            value: showDetails,
            onChanged: (value) {
              setState(() {
                showDetails = value;
              });
            },
            activeColor: const Color(0xFF87CEEB),
          ),
          
          const SizedBox(height: 20),
          
          // Ringkasan
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSummaryRow('Total Pendapatan', 'Rp ${totalPendapatan.toStringAsFixed(0)}'),
                const Divider(),
                _buildSummaryRow('Total Balok Terjual', '$totalBalok balok'),
                const Divider(),
                _buildSummaryRow('Total Transaksi', '${DataPesanan.daftarPesanan.length}'),
              ],
            ),
          ),
          
          if (showDetails) ...[
            const SizedBox(height: 30),
            const Text(
              'Detail Transaksi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DataPesanan.daftarPesanan.length,
              itemBuilder: (context, index) {
                final pesanan = DataPesanan.daftarPesanan[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(pesanan.status),
                      child: Text(pesanan.jumlah.toString()),
                    ),
                    title: Text('ID: ${pesanan.id}'),
                    subtitle: Text('Rp ${pesanan.total.toStringAsFixed(0)}'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama: ${pesanan.namaUser}'),
                            Text('No HP: ${pesanan.noHp}'),
                            Text('Alamat: ${pesanan.alamat}'),
                            Text('Tanggal: ${pesanan.tanggal}'),
                            Text('Status: ${pesanan.status}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF87CEEB),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Dalam Perjalanan':
        return Colors.orange;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}