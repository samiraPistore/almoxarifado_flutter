class Produto{
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
}
