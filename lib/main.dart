import 'package:flutter/material.dart';
import 'package:projectpkl/DashboardPage.dart';
import 'package:projectpkl/fromlogin.dart';
import 'package:projectpkl/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardPage(),
        '/Dashboard': (context) => LoginPage(),
        '/Homelogin': (context) => HomePage(),
      },
    );
  }
}



