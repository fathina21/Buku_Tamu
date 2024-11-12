import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'buku_tamu_page.dart'; // Halaman utama aplikasi Buku Tamu

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Tamu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BukuTamuPage(), // Halaman utama Buku Tamu
    );
  }
}
