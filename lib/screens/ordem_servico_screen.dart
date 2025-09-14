import 'package:flutter/material.dart';
import '../models/usuario_modelo.dart';

class OrdemServicoScreen extends StatefulWidget {
  final Usuario usuarioLogado;
  final List<Usuario> colaboradores;

  const OrdemServicoScreen({
    super.key,
    required this.usuarioLogado,
    required this.colaboradores,
  });

  @override
  State<OrdemServicoScreen> createState() => _OrdemServicoScreenState();
}

class _OrdemServicoScreenState extends State<OrdemServicoScreen> {
  int osNumero = 1; // Número automático da OS
  DateTime? dataSolicitacao;
  String tipoManutencao = '';
  Usuario? colaboradorSelecionado;
  String setorManutencao = '';
  DateTime? dataFinalizacao;
  String observacao = '';
  String? fotoPath;

  final TextEditingController tipoController = TextEditingController();
  final TextEditingController setorController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  Future<void> _pickDataSolicitacao() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => dataSolicitacao = picked);
  }

  Future<void> _pickDataFinalizacao() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => dataFinalizacao = picked);
  }

  void _salvarOrdemServico() {
    if (dataSolicitacao == null ||
        tipoManutencao.isEmpty ||
        colaboradorSelecionado == null ||
        setorManutencao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ordem de Serviço #$osNumero salva com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      osNumero++;
      dataSolicitacao = null;
      tipoManutencao = '';
      colaboradorSelecionado = null;
      setorManutencao = '';
      dataFinalizacao = null;
      fotoPath = null;
      observacaoController.clear();
      tipoController.clear();
      setorController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordem de Serviço - Usuário: ${widget.usuarioLogado.nome}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('OS Nº $osNumero', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Data de solicitação
            Row(
              children: [
                Expanded(
                  child: Text(
                    dataSolicitacao != null
                        ? 'Data Solicitação: ${dataSolicitacao!.day}/${dataSolicitacao!.month}/${dataSolicitacao!.year}'
                        : 'Selecione a data da solicitação',
                  ),
                ),
                IconButton(icon: const Icon(Icons.calendar_today), onPressed: _pickDataSolicitacao),
              ],
            ),
            const SizedBox(height: 10),

            // Tipo da manutenção
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipo da Manutenção', border: OutlineInputBorder()),
              onChanged: (val) => tipoManutencao = val,
            ),
            const SizedBox(height: 10),

            // Seleção do colaborador
            DropdownButtonFormField<Usuario>(
              value: colaboradorSelecionado,
              decoration: const InputDecoration(labelText: 'Colaborador', border: OutlineInputBorder()),
              items: widget.colaboradores
                  .map((u) => DropdownMenuItem(
                        value: u,
                        child: Text(u.nome),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => colaboradorSelecionado = val),
            ),
            const SizedBox(height: 10),

            // Setor da manutenção
            TextField(
              controller: setorController,
              decoration: const InputDecoration(labelText: 'Setor da Manutenção', border: OutlineInputBorder()),
              onChanged: (val) => setorManutencao = val,
            ),
            const SizedBox(height: 10),

            // Data finalização
            Row(
              children: [
                Expanded(
                  child: Text(
                    dataFinalizacao != null
                        ? 'Data Finalização: ${dataFinalizacao!.day}/${dataFinalizacao!.month}/${dataFinalizacao!.year}'
                        : 'Selecione a data de finalização',
                  ),
                ),
                IconButton(icon: const Icon(Icons.calendar_today), onPressed: _pickDataFinalizacao),
              ],
            ),
            const SizedBox(height: 10),

            // Foto opcional
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Função de foto não implementada ainda')),
                );
              },
              child: const Text('Adicionar Foto (Opcional)'),
            ),
            const SizedBox(height: 10),

            // Observação
            TextField(
              controller: observacaoController,
              decoration: const InputDecoration(labelText: 'Observação', border: OutlineInputBorder()),
              maxLines: 3,
              onChanged: (val) => observacao = val,
            ),
            const SizedBox(height: 20),

            ElevatedButton(onPressed: _salvarOrdemServico, child: const Text('Salvar Ordem de Serviço')),
          ],
        ),
      ),
    );
  }
}
