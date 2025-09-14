import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'usuario_modelo.dart';

class FiltroServicoScreen extends StatefulWidget {
  final Usuario usuarioLogado;
  const FiltroServicoScreen({super.key, required this.usuarioLogado});

  @override
  State<FiltroServicoScreen> createState() => _FiltroServicoScreenState();
}

class _FiltroServicoScreenState extends State<FiltroServicoScreen> {
  final TextEditingController colaboradorController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  List<Servico> resultados = [];

  void _filtrar() {
    final filtroColaborador = colaboradorController.text.toLowerCase();
    final filtroLocal = localController.text.toLowerCase();

    setState(() {
      resultados = listaServicos.where((s) {
        final matchesColaborador = filtroColaborador.isEmpty || s.colaborador.toLowerCase().contains(filtroColaborador);
        final matchesLocal = filtroLocal.isEmpty || s.descricao.toLowerCase().contains(filtroLocal);
        return matchesColaborador && matchesLocal;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrar Ordem de Serviço", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFB2DFDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFB2DFDB),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: colaboradorController, decoration: const InputDecoration(labelText: "Buscar por Colaborador")),
            const SizedBox(height: 10),
            TextField(controller: localController, decoration: const InputDecoration(labelText: "Buscar por Local/Serviço")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _filtrar, child: const Text("Filtrar")),
            const SizedBox(height: 20),
            const Text("Resultados:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: resultados.length,
                itemBuilder: (context, index) {
                  final s = resultados[index];
                  return ListTile(
                    title: Text(s.descricao),
                    subtitle: Text("Colaborador: ${s.colaborador} | Status: ${s.status}"),
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
