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
}