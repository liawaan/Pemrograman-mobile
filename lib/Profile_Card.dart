import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  // 1. Konstruktor & Properti Wajib
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  });

  // Helper internal untuk mengekstrak digit NIM
  int _getDigitAt(int positionFromLast) {
    // Menghapus karakter non-digit jika ada
    final cleanNim = nim.replaceAll(RegExp(r'\D'), '');
    if (cleanNim.length < positionFromLast) return 0;
    final charIndex = cleanNim.length - positionFromLast;
    return int.tryParse(cleanNim[charIndex]) ?? 0;
  }

  // Helper untuk mengekstrak 2 digit terakhir NIM
  static int hitungSkorAktivitasOtomatis(String nimString) {
    final cleanNim = nimString.replaceAll(RegExp(r'\D'), '');
    if (cleanNim.length < 2) return 50;
    final lastTwo = cleanNim.substring(cleanNim.length - 2);
    final val = int.tryParse(lastTwo) ?? 0;
    // Formula Skor Aktivitas: (2 digit terakhir NIM) + 50
    return val + 50;
  }

  @override
  Widget build(BuildContext context) {
    // Extracted digits
    final int digitTerakhir = _getDigitAt(1);
    final int digitKe2Belakang = _getDigitAt(2);

    // -------------------------------------------------------------
    // FORMULA PERHITUNGAN DINAMIS BERDASARKAN NIM
    // -------------------------------------------------------------
    final double lebarKartu = 320.0 + (digitKe2Belakang * 5.0);

    final double sudutMelengkung = 12.0 + (digitTerakhir * 1.5);

    // 3. Ukuran Logo = 60.0 + (Digit terakhir * 2)
    final double ukuranLogo = 60.0 + (digitTerakhir * 2.0);

    // 4. Jarak Pemisah Horizontal = 15.0 + (Digit terakhir)
    final double jarakPemisah = 15.0 + digitTerakhir.toDouble();

    return Container(
      width: lebarKartu,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(20.0),
      // Root Kartu: Container dengan BoxDecoration
      decoration: BoxDecoration(
        color: Colors.white, // Latar Belakang: Colors.white
        borderRadius: BorderRadius.circular(sudutMelengkung),
        boxShadow: [
          // Bayangan (BoxShadow) warna hitam transparan & blurRadius: 10.0
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Header Kartu (Horizontal - Row)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sisi Kiri: Logo/Ikon FlutterLogo dalam Container berbingkai
              Container(
                width: ukuranLogo,
                height: ukuranLogo,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200, width: 1.5),
                ),
                child: FlutterLogo(size: ukuranLogo),
              ),

              // Jarak Pemisah Horizontal menggunakan SizedBox
              SizedBox(width: jarakPemisah),

              // Sisi Kanan: Column dengan CrossAxisAlignment.start
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kartu Praktikan",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),
          // Pemisah: Widget Divider(thickness: 1.5)
          const Divider(thickness: 1.5, color: Colors.grey),
          const SizedBox(height: 12.0),

          // Bagian Detail Identitas (Vertikal - Column)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(
                label: "NIM",
                value: nim,
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 10.0),
              _buildDetailItem(
                label: "Hobi",
                value: hobi,
                icon: Icons.interests_outlined,
              ),
              const SizedBox(height: 10.0),
              _buildDetailItem(
                label: "Skor Aktivitas",
                value: "$skorAktivitas Poin",
                icon: Icons.star_outline_rounded,
                valueColor: Colors.blueAccent.shade100,
              ),
            ],
          ),

          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "Hasil Formula NIM ($nim):\n"
                  "• Lebar: $lebarKartu | Radius: $sudutMelengkung\n"
                  "• Size Logo: $ukuranLogo | Jarak: $jarakPemisah",
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk menampilkan baris identitas dengan TextStyle tebal (w600)
  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
    Color valueColor = Colors.black87,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18.0, color: Colors.grey.shade600),
        const SizedBox(width: 8.0),
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600, // FontWeight.w600 sesuai ketentuan
            color: Colors.black54,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600, // FontWeight.w600 sesuai ketentuan
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}