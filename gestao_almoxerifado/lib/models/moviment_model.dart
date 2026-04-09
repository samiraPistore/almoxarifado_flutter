class Movimentacao {
  String id;
  String produtoId;
  String tipo; // "entrada" ou "saida"
  int quantidade;
  DateTime data;
  String responsavel;
  String? obs;
  String? destino;    // saída

  Movimentacao({
    required this.id,
    required this.produtoId,
    required this.tipo,
    required this.quantidade,
    required this.data,
    required this.responsavel,
    this.obs,
    this.destino,
  });

  //Construtor que cria um objeto a patir de um Json
 factory Movimentacao.fromJson(Map<String, dynamic> json) {
  return Movimentacao(
    id: json['id']?.toString() ?? '',
    produtoId: json['produtoId']?.toString() ?? '',
    tipo: json['tipo'] ?? '',
    quantidade: json['quantidade'] ?? 0,
    data: json['data'] != null
        ? DateTime.parse(json['data'])
        : DateTime.now(),
    responsavel: json['responsavel'] ?? '',
    obs: json['obs'],
    destino: json['destino'], // pode ser null mesmo ✔
  );
}
}