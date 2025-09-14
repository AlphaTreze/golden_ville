import 'package:flutter/material.dart';
import 'usuario_modelo.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  final Usuario usuarioLogado;
  const CadastroUsuarioScreen({super.key, required this.usuarioLogado});

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController setorController = TextEditingController();
  String nivel = "comum";
  String? fotoPath;

  void _salvarUsuario() {
    if (nomeController.text.isEmpty ||
        loginController.text.isEmpty ||
        senhaController.text.isEmpty ||
        setorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos")),
      );
      return;
    }

    final novoUsuario = Usuario(
      nome: nomeController.text,
      login: loginController.text,
      senha: senhaController.text,
      setor: setorController.text,
      nivel: nivel,
      foto: fotoPath,
    );

    setState(() {
      listaUsuarios.add(novoUsuario);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Usuário cadastrado com sucesso!")),
    );

    // limpar campos
    nomeController.clear();
    loginController.clear();
    senhaController.clear();
    setorController.clear();
    setState(() {
      nivel = "comum";
      fotoPath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // apenas Master pode acessar essa tela
    if (widget.usuarioLogado.nivel != "master") {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Acesso Negado"),
          backgroundColor: const Color(0xFFB2DFDB),
        ),
        body: const Center(child: Text("Somente usuários Master podem acessar esta tela.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuário", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFB2DFDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFB2DFDB),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nomeController, decoration: const InputDecoration(labelText: "Nome do Colaborador")),
              const SizedBox(height: 10),
              TextField(controller: loginController, decoration: const InputDecoration(labelText: "Login")),
              const SizedBox(height: 10),
              TextField(controller: senhaController, decoration: const InputDecoration(labelText: "Senha"), obscureText: true),
              const SizedBox(height: 10),
              TextField(controller: setorController, decoration: const InputDecoration(labelText: "Setor")),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: nivel,
                decoration: const InputDecoration(labelText: "Nível de Acesso"),
                items: const [
                  DropdownMenuItem(value: "comum", child: Text("Comum")),
                  DropdownMenuItem(value: "master", child: Text("Master")),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => nivel = value);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _salvarUsuario, child: const Text("Salvar Usuário")),
              const SizedBox(height: 20),
              const Text("Lista de Usuários Cadastrados:", style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listaUsuarios.length,
                itemBuilder: (context, index) {
                  final u = listaUsuarios[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: u.foto == null ? const Icon(Icons.person) : null,
                      backgroundImage: u.foto != null ? AssetImage(u.foto!) : null,
                    ),
                    title: Text(u.nome),
                    subtitle: Text("${u.setor} - ${u.nivel}"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
