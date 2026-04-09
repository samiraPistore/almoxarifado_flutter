class DashboardModel{
  int totalMov;
  int totalProd;
  int estoqueBaixo;
  int totalEntrada;
  int totalSaida;

  DashboardModel({
    required this.totalMov,
    required this.totalProd,
    required this.totalEntrada,
    required this.totalSaida,
    required this.estoqueBaixo,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json){
    return DashboardModel(
      totalMov: int.tryParse(json['totalMov'].toString()) ?? 0, 
      totalProd: int.tryParse(json ['totalProd'].toString()) ?? 0, 
      totalEntrada: int.tryParse(json['totalEntrada'].toString()) ?? 0,  
      totalSaida: int.tryParse(json['totalSaida'].toString()) ?? 0,
      estoqueBaixo: int.tryParse(json['estoqueBaixo'].toString()) ?? 0,
    );
  }
}