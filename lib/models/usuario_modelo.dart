class Usuario {
  String nome;
  String login;
  String senha;
  String nivel;
  String setor;

  Usuario({
    required this.nome,
    required this.login,
    required this.senha,
    required this.nivel,
    required this.setor,
  });
}

// LISTA GLOBAL
List<Usuario> usuariosCadastrados = [
  Usuario(nome: "Admin", login: "admin", senha: "admin123", nivel: "master", setor: "TI"),
  Usuario(nome: "Eduardo", login: "eduardo", senha: "123", nivel: "comum", setor: "Manutenção"),
  Usuario(nome: "Maria", login: "maria", senha: "123", nivel: "comum", setor: "Limpeza"),
];
