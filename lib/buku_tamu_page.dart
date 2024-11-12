// buku_tamu_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BukuTamuPage extends StatefulWidget {
  @override
  _BukuTamuPageState createState() => _BukuTamuPageState();
}

class _BukuTamuPageState extends State<BukuTamuPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void _submitData() {
    final name = _nameController.text;
    final email = _emailController.text;

    if (name.isEmpty || email.isEmpty) {
      return;
    }

    // Menyimpan data ke Firestore
    FirebaseFirestore.instance.collection('guests').add({
      'name': name,
      'email': email,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _nameController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buku Tamu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Kirim'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('guests')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Belum ada tamu yang datang.'));
                  }

                  final guests = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: guests.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(guests[index]['name']),
                        subtitle: Text(guests[index]['email']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
