import 'package:flutter/material.dart';
import '../models/usuario_modelo.dart'; // Import do modelo de usuário
import 'ordem_servico_screen.dart';

class DashboardScreen extends StatelessWidget {
  final Usuario usuarioLogado;

  const DashboardScreen({super.key, required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    // Filtra apenas os colaboradores de nível "comum"
    List<Usuario> colaboradores = usuariosCadastrados.where((u) => u.nivel == 'comum').toList();

    // Lista de cards de funcionalidades
    final List<_DashboardCard> cards = [
      _DashboardCard(
        title: 'Nova Ordem de Serviço',
        icon: Icons.add_box,
        color: Colors.teal,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrdemServicoScreen(
                usuarioLogado: usuarioLogado,
                colaboradores: colaboradores,
              ),
            ),
          );
        },
      ),
      _DashboardCard(
        title: 'Ordens de Serviço Abertas',
        icon: Icons.pending_actions,
        color: Colors.orange,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Funcionalidade ainda não implementada')),
          );
        },
      ),
      _DashboardCard(
        title: 'Ordens de Serviço Finalizadas',
        icon: Icons.check_circle,
        color: Colors.green,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Funcionalidade ainda não implementada')),
          );
        },
      ),
      _DashboardCard(
        title: 'Configurações',
        icon: Icons.settings,
        color: Colors.blueGrey,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Funcionalidade ainda não implementada')),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard - ${usuarioLogado.nome}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo, ${usuarioLogado.nome}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Define quantidade de colunas dependendo da largura
                  int crossAxisCount = constraints.maxWidth > 800
                      ? 4
                      : constraints.maxWidth > 600
                          ? 2
                          : 1;

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: cards.map((card) {
                      return GestureDetector(
                        onTap: card.onTap,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          color: card.color,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(card.icon, size: 50, color: Colors.white),
                                const SizedBox(height: 10),
                                Text(
                                  card.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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

// Classe auxiliar para os cards do dashboard
class _DashboardCard {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
