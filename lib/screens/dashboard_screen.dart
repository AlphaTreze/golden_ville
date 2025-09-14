import 'package:flutter/material.dart';
import 'ordem_servico_screen.dart';
import 'filtro_servico_screen.dart';
import 'cadastro_usuario_screen.dart';
import 'usuario_modelo.dart';
import '../widgets/rodape.dart';

class Servico {
  String descricao;
  String status; // "Aberto" ou "Finalizado"
  String colaborador;

  Servico({
    required this.descricao,
    required this.status,
    required this.colaborador,
  });
}

List<Servico> listaServicos = [
  Servico(descricao: "Troca de lâmpada", status: "Aberto", colaborador: "João"),
  Servico(descricao: "Reparo hidráulico", status: "Finalizado", colaborador: "Carlos"),
];

class DashboardScreen extends StatelessWidget {
  final Usuario usuarioLogado;
  const DashboardScreen({super.key, required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    final abertos = listaServicos.where((s) => s.status == "Aberto").take(10).toList();
    final finalizados = listaServicos.where((s) => s.status == "Finalizado").take(5).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2DFDB),
        title: Text("Dashboard - ${usuarioLogado.nome}", style: const TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFB2DFDB),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Últimos 10 Serviços em Aberto",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            Expanded(
              child: ListView.builder(
                itemCount: abertos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(abertos[index].descricao, style: const TextStyle(color: Colors.black)),
                    subtitle: Text("Colaborador: ${abertos[index].colaborador}", style: const TextStyle(color: Colors.black54)),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text("Últimos 5 Serviços Finalizados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: finalizados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(finalizados[index].descricao, style: const TextStyle(color: Colors.black)),
                    subtitle: Text("Colaborador: ${finalizados[index].colaborador}", style: const TextStyle(color: Colors.black54)),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrdemServicoScreen(usuarioLogado: usuarioLogado),
                      ),
                    );
                  },
                  child: const Text("Criar Ordem de Serviço"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FiltroServicoScreen(usuarioLogado: usuarioLogado),
                      ),
                    );
                  },
                  child: const Text("Filtrar OS"),
                ),
                if (usuarioLogado.nivel == "master")
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CadastroUsuarioScreen(usuarioLogado: usuarioLogado),
                        ),
                      );
                    },
                    child: const Text("Cadastrar Usuário"),
                  ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Rodape(),
    );
  }
}
