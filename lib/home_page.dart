import 'package:flutter/material.dart';
import 'package:projectpkl/fromlogin.dart';


import 'package:projectpkl/read.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Konfirmasi Logout"),
              content: Text("Yakin ingin keluar?"),
              actions: [
                TextButton(
                  child: Text("Tidak"),
                  onPressed: () {
                    Navigator.of(context).pop(false); // Tutup AlertDialog dan kembalikan nilai false
                  },
                ),
                TextButton(
                  child: Text("Ya"),
                  onPressed: () {
                    Navigator.of(context).pop(true); // Tutup AlertDialog dan kembalikan nilai true
                    // Tambahkan kode logout di sini
                    // Contoh logout:
                    Navigator.pushReplacement( // Navigasi ke halaman InputField setelah logout
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan nama class halaman InputField
                    );
                  },
                ),
              ],
            );
          },
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReadPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Welcome, Admin!'),
        ),
      ),
    );
  }
}
