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

// Lista global de serviços
List<Servico> listaServicos = [
  Servico(descricao: "Troca de lâmpada", status: "Aberto", colaborador: "João"),
  Servico(descricao: "Reparo hidráulico", status: "Finalizado", colaborador: "Carlos"),
];
