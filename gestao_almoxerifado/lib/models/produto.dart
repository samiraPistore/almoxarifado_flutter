class Produto {
  String id;
  String nome;
  String codigo;
  String categotia;
  String uniMedida;
  int qtdMin;
  int qtdAtual;
  String localEstoq;
  double valorUni;

  Produto({
    required this.id,
    required this.nome,
    required this.codigo,
    required this.categotia,
    required this.uniMedida,
    required this.qtdMin,
    required this.qtdAtual,
    required this.localEstoq,
    required this.valorUni,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'].toString(),
      nome: json['nome'],
      codigo: json['codigo'],
      categotia: json['categotia'],
      uniMedida: json['uniMedida'],
      qtdMin: json['qtdMin'] ?? 0,
      qtdAtual: json['qtdAtual'] ?? 0,
      localEstoq: json['localEstoq'],
      valorUni: (json['valorUni'] as num).toDouble(),
    );
  }

}