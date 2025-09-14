class Usuario {
  String nome;
  String login;
  String senha;
  String setor;
  String nivel; // "comum" ou "master"
  String? foto;

  Usuario({
    required this.nome,
    required this.login,
    required this.senha,
    required this.setor,
    required this.nivel,
    this.foto,
  });
}

List<Usuario> listaUsuarios = [
  Usuario(
    nome: "ADMIN",
    login: "admin",
    senha: "admin123",
    setor: "TI",
    nivel: "master",
    foto: null,
  ),
];
