import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:projectpkl/Update.dart';
import 'package:projectpkl/home_page.dart'; // Import halaman admin

class ReadPage extends StatefulWidget {
  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
  }

  Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse("http://localhost/phpflutter/read.php"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataFuture = getData();
    });
  }

  Future<void> _deleteData(int id) async {
    String url = 'http://localhost/phpflutter/delete.php?id=$id';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Data deleted successfully, refresh the data
        _refreshData();
        print("Data deleted successfully");
      } else {
        print("Error deleting data: ${response.body}");
      }
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      title: 'Aplikasi Tamu',
      theme: ThemeData(
        primaryColor: Colors.red, // Warna utama aplikasi menjadi merah
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent, // Warna aksen aplikasi menjadi merah muda
        ),
        // Atur gaya teks untuk judul aplikasi
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Tamu'),
          leading: IconButton(
            icon: Icon(Icons.home), // Icon homepage
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()), // Navigasi ke halaman admin
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app), // Icon keluar
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Navigasi ke halaman admin
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<dynamic>>(
          future: _dataFuture,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text("ID: ${snapshot.data![index]['id']}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Full Name: ${snapshot.data![index]['full_name']}"),
                            Text("Phone Number: ${snapshot.data![index]['phone_number']}"),
                            Text("Full Addres: ${snapshot.data![index]['full_addres']}"),
                            Text("Date: ${snapshot.data![index]['date']}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                // Add navigation to edit page
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(data: snapshot.data![index]),
                                  ),
                                );
                                // Refresh data after returning from edit page
                                _refreshData();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Data'),
                                      content: Text('Are you sure you want to delete this data?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close dialog
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            int idToDelete = int.parse(snapshot.data![index]['id']); // Convert ID to integer
                                            _deleteData(idToDelete); // Pass integer ID to delete function
                                            Navigator.of(context).pop(); // Close dialog
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
