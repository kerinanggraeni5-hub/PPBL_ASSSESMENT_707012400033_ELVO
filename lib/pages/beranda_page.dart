import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../state/belanja_cubit.dart';
import '../state/favorit_provider.dart';
import 'form_pemesanan_page.dart';
import 'katalog_page.dart';
import 'lokasi_page.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EcoMart')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Selamat Datang di EcoMart - Produk Daur Ulang',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Komunitas Bank Sampah Hijau Kota Bandung menghasilkan berbagai produk dari '
              'pengolahan sampah rumah tangga, seperti pupuk kompos, '
              'pot tanaman, tas daur ulang, dan kerajinan tangan.',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KatalogPage()),
                );
              },
              child: const Text('Lihat Katalog'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FormPemesananPage(),
                  ),
                );
              },
              child: const Text('Form Pemesanan'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LokasiPage()),
                );
              },
              child: const Text('Lokasi GreenLife'),
            ),
            const SizedBox(height: 24),
            Consumer<FavoritProvider>(
              builder: (context, favorit, child) {
                return Text('Jumlah favorit: ${favorit.jumlahFavorit}');
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<BelanjaCubit, int>(
              builder: (context, jumlah) {
                return Text('Barang dalam keranjang: $jumlah');
              },
            ),
          ],
        ),
      ),
    );
  }
}
