import 'package:flutter/material.dart';

class FormPemesananPage extends StatefulWidget {
  const FormPemesananPage({super.key});

  @override
  State<FormPemesananPage> createState() => _FormPemesananPageState();
}

class _FormPemesananPageState extends State<FormPemesananPage> {
  final namaController = TextEditingController();
  final teleponController = TextEditingController();
  String metodePembayaran = 'Tunai';
  bool setuju = false;

  @override
  void dispose() {
    namaController.dispose();
    teleponController.dispose();
    super.dispose();
  }

  void kirimPesanan() {
    if (!setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Centang persetujuan terlebih dahulu')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pesanan berhasil dikirim')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Pembeli',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: teleponController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Metode Pembayaran'),
          RadioListTile<String>(
            title: const Text('Tunai'),
            value: 'Tunai',
            groupValue: metodePembayaran,
            onChanged: (value) {
              setState(() => metodePembayaran = value!);
            },
          ),
          RadioListTile<String>(
            title: const Text('Transfer'),
            value: 'Transfer',
            groupValue: metodePembayaran,
            onChanged: (value) {
              setState(() => metodePembayaran = value!);
            },
          ),
          Row(
            children: [
              Checkbox(
                value: setuju,
                onChanged: (value) {
                  setState(() => setuju = value ?? false);
                },
              ),
              const Expanded(child: Text('Saya menyetujui pesanan ini')),
            ],
          ),
          FilledButton(
            onPressed: kirimPesanan,
            child: const Text('Kirim Pesanan'),
          ),
        ],
      ),
    );
  }
}
