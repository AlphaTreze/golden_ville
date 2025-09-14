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

// Banco simulado em memória
List<Servico> listaServicos = [
  Servico(descricao: "Troca de lâmpada", status: "Aberto", colaborador: "João"),
  Servico(descricao: "Reparo hidráulico", status: "Finalizado", colaborador: "Carlos"),
  Servico(descricao: "Limpeza da piscina", status: "Aberto", colaborador: "Ana"),
  Servico(descricao: "Conserto do portão", status: "Finalizado", colaborador: "Marcos"),
];
