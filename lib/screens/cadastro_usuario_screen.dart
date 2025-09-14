import 'package:flutter/material.dart';
import '../models/usuario_modelo.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  final Usuario usuarioLogado;
  const CadastroUsuarioScreen({super.key, required this.usuarioLogado});

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final nomeController = TextEditingController();
  final loginController = TextEditingController();
  final senhaController = TextEditingController();
  final setorController = TextEditingController();

  void salvarUsuario() {
    if (nomeController.text.isEmpty || loginController.text.isEmpty || senhaController.text.isEmpty || setorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos"), backgroundColor: Colors.red, duration: Duration(seconds: 2))
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Usuário ${nomeController.text} cadastrado com sucesso!"), backgroundColor: Colors.green, duration: const Duration(seconds: 2))
    );

    if (widget.usuarioLogado.nivel == "master") {
      Future.delayed(const Duration(seconds: 2), () {
        nomeController.clear();
        loginController.clear();
        senhaController.clear();
        setorController.clear();
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DFDB),
      appBar: AppBar(title: const Text("Cadastro de Usuário"), backgroundColor: const Color(0xFFB2DFDB)),
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
                    TextField(controller: nomeController, decoration: const InputDecoration(labelText: "Nome")),
                    const SizedBox(height: 10),
                    TextField(controller: loginController, decoration: const InputDecoration(labelText: "Login")),
                    const SizedBox(height: 10),
                    TextField(controller: senhaController, decoration: const InputDecoration(labelText: "Senha"), obscureText: true),
                    const SizedBox(height: 10),
                    TextField(controller: setorController, decoration: const InputDecoration(labelText: "Setor")),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: salvarUsuario, child: const Text("Salvar")),
                    const SizedBox(height: 10),
                    if (widget.usuarioLogado.nivel == "master")
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text("Voltar para Dashboard"),
                      ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    loginController.dispose();
    senhaController.dispose();
    setorController.dispose();
    super.dispose();
  }
}
