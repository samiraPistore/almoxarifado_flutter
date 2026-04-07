class Produto {
  String id;
  String nome;
  String codigo;
  String categoria;
  String uniMedida;
  int qtdMin;
  int qtdAtual;
  String localEstoq;
  double valorUni;

  Produto({
    required this.id,
    required this.nome,
    required this.codigo,
    required this.categoria,
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
      categoria: json['categoria'], // corrigido aqui
      uniMedida: json['uniMedida'],
      qtdMin: int.tryParse(json['qtdMin'].toString()) ?? 0,
      qtdAtual: int.tryParse(json['qtdAtual'].toString()) ?? 0,
      localEstoq: json['localEstoq'],
      valorUni: double.tryParse(json['valorUni'].toString()) ?? 0.0,
    );
  }
}
