import 'package:flutter/material.dart';
import 'package:projectpkl/DataTamu.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_sharp,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'GUESTBOOKS!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Spacer untuk memberikan ruang di antara teks "GUESTBOOKS!" dan teks berikutnya
            Text(
              'This application is used to record visiting guests',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // Spacer untuk memberikan ruang di antara teks dan tombol
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataTamu()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // warna latar belakang tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // ubah nilai sesuai dengan keinginan
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // ubah lebar dan tinggi tombol sesuai keinginan
              ),
              child: Text(
                'Enter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
