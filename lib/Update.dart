import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Map<String, dynamic> data;

  EditPage({required this.data});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _fullAddresController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.data['full_name']);
    _phoneNumberController = TextEditingController(text: widget.data['phone_number']);
    _fullAddresController = TextEditingController(text: widget.data['full_addres']);
    _dateController = TextEditingController(text: widget.data['date']);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _fullAddresController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _updateData() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Text('Apakah Anda ingin menyimpan perubahan ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                _saveChanges(); // Panggil method untuk menyimpan perubahan
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveChanges() async {
    final url = Uri.parse('http://localhost/phpflutter/update.php');
    final response = await http.post(
      url,
      body: {
        'id': widget.data['id'].toString(),
        'full_name': _fullNameController.text,
        'phone_number': _phoneNumberController.text,
        'full_addres': _fullAddresController.text,
        'date': _dateController.text,
      },
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update data'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() {
      _dateController.text = picked.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              controller: _fullAddresController,
              decoration: InputDecoration(labelText: 'Full Address'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateData();
              },
              child: Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
