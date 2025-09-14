import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'usuario_modelo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OrdemServico {
  int numero;
  DateTime dataSolicitacao;
  String tipoManutencao;
  Usuario colaborador;
  String setor;
  DateTime? dataFinalizacao;
  String? foto; // caminho local da foto
  String observacao;

  OrdemServico({
    required this.numero,
    required this.dataSolicitacao,
    required this.tipoManutencao,
    required this.colaborador,
    required this.setor,
    this.dataFinalizacao,
    this.foto,
    required this.observacao,
  });
}

List<OrdemServico> listaOrdensServico = [];

class OrdemServicoScreen extends StatefulWidget {
  final Usuario usuarioLogado;
  const OrdemServicoScreen({super.key, required this.usuarioLogado});

  @override
  State<OrdemServicoScreen> createState() => _OrdemServicoScreenState();
}

class _OrdemServicoScreenState extends State<OrdemServicoScreen> {
  int _numeroOrdem = 1;
  DateTime? _dataSolicitacao;
  DateTime? _dataFinalizacao;
  String tipoManutencao = "";
  Usuario? colaboradorSelecionado;
  String setor = "";
  String? fotoPath;
  String observacao = "";

  final TextEditingController tipoController = TextEditingController();
  final TextEditingController setorController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _numeroOrdem = listaOrdensServico.isEmpty
        ? 1
        : listaOrdensServico.last.numero + 1;
  }

  Future<void> _selecionarFoto() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.gallery);
    if (imagem != null) {
      setState(() {
        fotoPath = imagem.path;
      });
    }
  }

  void _selecionarDataSolicitacao() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      setState(() => _dataSolicitacao = data);
    }
  }

  void _selecionarDataFinalizacao() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      setState(() => _dataFinalizacao = data);
    }
  }

  void _limparCampos() {
    setState(() {
      _numeroOrdem = listaOrdensServico.isEmpty
          ? 1
          : listaOrdensServico.last.numero + 1;
      _dataSolicitacao = null;
      _dataFinalizacao = null;
      tipoManutencao = "";
      colaboradorSelecionado = null;
      setor = "";
      fotoPath = null;
      observacao = "";
      tipoController.clear();
      setorController.clear();
      observacaoController.clear();
    });
  }

  void _salvarOrdem() {
    if (_dataSolicitacao == null ||
        tipoManutencao.isEmpty ||
        colaboradorSelecionado == null ||
        setor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos obrigatórios")),
      );
      return;
    }

    final novaOrdem = OrdemServico(
      numero: _numeroOrdem,
      dataSolicitacao: _dataSolicitacao!,
      tipoManutencao: tipoManutencao,
      colaborador: colaboradorSelecionado!,
      setor: setor,
      dataFinalizacao: _dataFinalizacao,
      foto: fotoPath,
      observacao: observacao,
    );

    setState(() {
      listaOrdensServico.add(novaOrdem);
      _limparCampos();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ordem de serviço salva com sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listaColaboradores =
        listaUsuarios.where((u) => u.nivel == "comum").toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ordem de Serviço", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFB2DFDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFB2DFDB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Ordem de Serviço: ",
                    style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text("$_numeroOrdem", style: const TextStyle(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(_dataSolicitacao == null
                  ? "Selecione Data Solicitação"
                  : "Data Solicitação: ${_dataSolicitacao!.day}/${_dataSolicitacao!.month}/${_dataSolicitacao!.year}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selecionarDataSolicitacao,
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: "Tipo da Manutenção"),
              onChanged: (val) => tipoManutencao = val,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<Usuario>(
              decoration: const InputDecoration(labelText: "Colaborador"),
              value: colaboradorSelecionado,
              items: listaColaboradores
                  .map((u) => DropdownMenuItem(
                        value: u,
                        child: Text(u.nome),
                      ))
                  .toList(),
              onChanged: (u) => setState(() => colaboradorSelecionado = u),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: setorController,
              decoration: const InputDecoration(labelText: "Setor da Manutenção"),
              onChanged: (val) => setor = val,
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(_dataFinalizacao == null
                  ? "Selecione Data Finalização"
                  : "Data Finalização: ${_dataFinalizacao!.day}/${_dataFinalizacao!.month}/${_dataFinalizacao!.year}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selecionarDataFinalizacao,
            ),
            const SizedBox(height: 10),
            // Upload de Foto
            Row(
              children: [
                ElevatedButton(
                  onPressed: _selecionarFoto,
                  child: const Text("Selecionar Foto"),
                ),
                const SizedBox(width: 10),
                fotoPath != null
                    ? Image.file(File(fotoPath!), width: 80, height: 80, fit: BoxFit.cover)
                    : const Text("Nenhuma foto selecionada", style: TextStyle(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: observacaoController,
              decoration: const InputDecoration(labelText: "Observação"),
              maxLines: 3,
              onChanged: (val) => observacao = val,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: _limparCampos, child: const Text("Limpar")),
                ElevatedButton(onPressed: _salvarOrdem, child: const Text("Salvar")),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Voltar")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
