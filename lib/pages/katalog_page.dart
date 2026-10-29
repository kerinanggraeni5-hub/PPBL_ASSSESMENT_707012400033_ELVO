import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../state/belanja_cubit.dart';
import '../state/favorit_provider.dart';

class Produk {
  final String nama;
  final int harga;

  const Produk({required this.nama, required this.harga});
}

String formatRupiah(int nilai) {
  final angka = nilai.toString();
  final hasil = StringBuffer('Rp');
  for (var i = 0; i < angka.length; i++) {
    if (i > 0 && (angka.length - i) % 3 == 0) hasil.write('.');
    hasil.write(angka[i]);
  }
  return hasil.toString();
}

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  final List<Produk> produk = const [
    Produk(nama: 'Pupuk Kompos Organik', harga: 15000),
    Produk(nama: 'Pot Tanaman Daur Ulang', harga: 25000),
    Produk(nama: 'Tas Kemasan Daur Ulang', harga: 35000),
  ];

  final List<int> jumlahPembelian = [1, 1, 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Produk')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Consumer<FavoritProvider>(
                  builder: (context, favorit, child) =>
                      Text('Jumlah favorit: ${favorit.jumlahFavorit}'),
                ),
                BlocBuilder<BelanjaCubit, int>(
                  builder: (context, jumlah) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Barang di keranjang: $jumlah'),
                      IconButton(
                        tooltip: 'Kurangi barang dari keranjang',
                        onPressed: () =>
                            context.read<BelanjaCubit>().kurangiBarang(),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: produk.length,
              itemBuilder: (context, index) {
                final item = produk[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(formatRupiah(item.harga)),
                        Row(
                          children: [
                            IconButton(
                              onPressed: jumlahPembelian[index] > 1
                                  ? () => setState(() => jumlahPembelian[index]--)
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),
                            Text('${jumlahPembelian[index]}'),
                            IconButton(
                              onPressed: () =>
                                  setState(() => jumlahPembelian[index]++),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => context
                                  .read<FavoritProvider>()
                                  .tambahFavorit(),
                              icon: const Icon(Icons.favorite_border),
                              label: const Text('Tambah Favorit'),
                            ),
                            FilledButton.icon(
                              onPressed: () => context
                                  .read<BelanjaCubit>()
                                  .tambahBarang(jumlahPembelian[index]),
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Tambah ke Keranjang'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ),
        ],
      ),
    );
  }
}
