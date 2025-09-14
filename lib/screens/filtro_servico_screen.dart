import 'package:flutter/material.dart';
import '../models/usuario_modelo.dart';
import '../models/servico_modelo.dart';
import '../widgets/rodape.dart';

class FiltroServicoScreen extends StatefulWidget {
  final Usuario usuarioLogado;
  const FiltroServicoScreen({super.key, required this.usuarioLogado});

  @override
  State<FiltroServicoScreen> createState() => _FiltroServicoScreenState();
}

class _FiltroServicoScreenState extends State<FiltroServicoScreen> {
  final statusController = TextEditingController();
  final colaboradorController = TextEditingController();
  List<Servico> resultados = [];

  void filtrarServicos() {
    String status = statusController.text.trim().toLowerCase();
    String colaborador = colaboradorController.text.trim().toLowerCase();

    setState(() {
      resultados = listaServicos.where((s) {
        bool statusMatch = status.isEmpty || s.status.toLowerCase().contains(status);
        bool colaboradorMatch = colaborador.isEmpty || s.colaborador.toLowerCase().contains(colaborador);
        return statusMatch && colaboradorMatch;
      }).toList();
    });

    if (resultados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nenhum serviço encontrado")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DFDB),
      appBar: AppBar(title: const Text("Filtrar Ordens de Serviço"), backgroundColor: const Color(0xFFB2DFDB)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: statusController,
                      decoration: const InputDecoration(
                        labelText: "Status (Aberto / Finalizado)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: colaboradorController,
                      decoration: const InputDecoration(
                        labelText: "Colaborador",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: filtrarServicos, child: const Text("Filtrar")),
                    const SizedBox(height: 20),
                    if (resultados.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resultados.length,
                        itemBuilder: (context, index) {
                          final s = resultados[index];
                          return ListTile(
                            title: Text(s.descricao),
                            subtitle: Text("Colaborador: ${s.colaborador}"),
                          );
                        },
                      ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const Rodape(),
    );
  }

  @override
  void dispose() {
    statusController.dispose();
    colaboradorController.dispose();
    super.dispose();
  }
}
