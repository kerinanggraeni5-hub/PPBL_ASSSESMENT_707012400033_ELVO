import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'pages/beranda_page.dart';
import 'state/belanja_cubit.dart';
import 'state/favorit_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider( //Menghubungkan Provider dengan aplikasi
      create: (_) => FavoritProvider(),
      child: BlocProvider(//Menggunakan BlocProvider 
        create: (_) => BelanjaCubit(),
        child: const EcoMartApp(),
      ),
    ),
  );
}

class EcoMartApp extends StatelessWidget {
  const EcoMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoMart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const BerandaPage(),
    );
  }
}