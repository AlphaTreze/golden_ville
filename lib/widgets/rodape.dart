import 'package:flutter/material.dart';

class Rodape extends StatelessWidget {
  const Rodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFB2DFDB),
      padding: const EdgeInsets.all(10),
      child: const Text(
        "Contato da Administração: (15) 99741-3900 | Responsável Técnico: Eduardo Borges",
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
