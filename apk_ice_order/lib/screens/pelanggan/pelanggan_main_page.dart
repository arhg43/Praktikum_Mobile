import 'package:flutter/material.dart';
import 'pelanggan_home_page.dart';
import 'pelanggan_transaksi_page.dart';
import 'pelanggan_profile_page.dart';

class PelangganMainPage extends StatefulWidget {
  final String username;
  const PelangganMainPage({Key? key, required this.username}) : super(key: key);

  @override
  State<PelangganMainPage> createState() => _PelangganMainPageState();
}

class _PelangganMainPageState extends State<PelangganMainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      PelangganHomePage(username: widget.username),
      const PelangganTransaksiPage(),
      PelangganProfilePage(username: widget.username),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: Colors.cyan,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz),
                label: 'TRANSAKSI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'PROFILE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
