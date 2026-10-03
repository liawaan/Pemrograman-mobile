import 'package:flutter/material.dart';
import 'profile_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String sampleNama = "Rafdi Muliawan";
  String sampleNim = "20240801160";
  String sampleHobi = "Menonton Film";

  late TextEditingController _nimController;
  late TextEditingController _namaController;
  late TextEditingController _hobiController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: sampleNama);
    _nimController = TextEditingController(text: sampleNim);
    _hobiController = TextEditingController(text: sampleHobi);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _hobiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int computedSkor =
    ProfileCard.hitungSkorAktivitasOtomatis(sampleNim);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card Praktikum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blueAccent.shade100,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Preview ProfileCard Praktikan'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: ProfileCard(
                  nama: sampleNama,
                  nim: sampleNim,
                  hobi: sampleHobi,
                  skorAktivitas: computedSkor,
                ),
              ),
              const SizedBox(height: 24.0),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Uji Coba Input NIM & Data",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nimController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "NIM",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _hobiController,
                        decoration: const InputDecoration(
                          labelText: "Hobi",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              sampleNama = _namaController.text;
                              sampleNim = _nimController.text;
                              sampleHobi = _hobiController.text;
                            });
                          },
                          child: const Text("Hitung Ulang & Update Kartu"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}