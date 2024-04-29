import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; // Import library untuk TextInputFormatter
import 'package:projectpkl/DashboardPage.dart'; // Import halaman DashboardPage

class InputField extends StatefulWidget {
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // TextInputFormatter untuk membatasi input hanya menerima angka
  final _phoneNumberFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  Future<void> kirimData() async {
    var url = Uri.http("localhost", "phpflutter/simpan.php");
    var response = await http.post(url, body: {
      "full_name": fullNameController.text,
      "phone_number": phoneNumberController.text,
      "full_addres": addresController.text,
      "date": dateController.text,
    });

    var data = json.decode(response.body);
    if (data.toString() == 'berhasil') {
      print("Tersambung!");

      // Tampilkan AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Data telah tersimpan'),
            content: Text('Apakah Anda ingin mengisi lagi?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  // Pindah ke halaman DashboardPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  // Bersihkan input field
                  fullNameController.clear();
                  phoneNumberController.clear();
                  addresController.clear();
                  dateController.clear();
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
    } else {
      print("Gagal!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: TextField(
            controller: fullNameController,
            decoration: InputDecoration(
              hintText: "Full name",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: TextField(
            controller: phoneNumberController,
            inputFormatters: [_phoneNumberFormatter], // Gunakan formatter untuk membatasi input hanya menerima angka
            decoration: InputDecoration(
              hintText: "Phone number",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: TextField(
            controller: addresController,
            decoration: InputDecoration(
              hintText: "Full addres",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: "Date",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            kirimData();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Adjust the color as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
          child: Container(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
