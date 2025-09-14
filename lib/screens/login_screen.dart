import 'package:flutter/material.dart';
import '../models/usuario_modelo.dart';
import 'dashboard_screen.dart';

List<Usuario> usuariosCadastrados = [
  Usuario(nome: "Admin", login: "master", senha: "123", nivel: "master", setor: "TI"),
  Usuario(nome: "Eduardo", login: "eduardo", senha: "123", nivel: "comum", setor: "Manutenção"),
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  void realizarLogin() {
    String login = loginController.text.trim();
    String senha = senhaController.text.trim();

    Usuario? usuario = usuariosCadastrados.firstWhere(
      (u) => u.login == login && u.senha == senha,
      orElse: () => Usuario(nome: "", login: "", senha: "", nivel: "", setor: ""),
    );

    if (usuario.nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login ou senha incorretos"), backgroundColor: Colors.red),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen(usuarioLogado: usuario)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2DFDB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Login Sistema Golden Ville", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 40),
                    TextField(controller: loginController, decoration: const InputDecoration(labelText: "Login", border: OutlineInputBorder())),
                    const SizedBox(height: 20),
                    TextField(controller: senhaController, decoration: const InputDecoration(labelText: "Senha", border: OutlineInputBorder()), obscureText: true),
                    const SizedBox(height: 30),
                    ElevatedButton(onPressed: realizarLogin, child: const Text("Entrar")),
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
    loginController.dispose();
    senhaController.dispose();
    super.dispose();
  }
}
