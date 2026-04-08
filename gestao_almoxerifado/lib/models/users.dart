class Users {
  String id;
  String nome;
  String cargo;
  String email;
  String senha;

  Users({
   required this.id,
   required this.nome,
   required this.cargo,
   required this.email,
   required this.senha,

  });

  //Construtor que cria um objeto a patir de um Json
  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
      id: json['id'].toString(),
      nome: json['nome'], 
      cargo: json['cargo'], 
      email: json['email'], 
      senha: json['senha'],

    );
  }
}