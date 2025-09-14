import 'package:flutter/material.dart';

class Rodape extends StatelessWidget {
  const Rodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFB2DFDB),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Golden Ville - Todos os direitos reservados", style: TextStyle(color: Colors.black)),
          SizedBox(height: 5),
          Text("Localização: Rua Exemplo, 123 - Cidade, Estado", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
