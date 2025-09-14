import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'widgets/rodape.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Residencial Golden Ville',
      theme: ThemeData(
        primaryColor: const Color(0xFFB2DFDB),
        scaffoldBackgroundColor: const Color(0xFFB2DFDB),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
