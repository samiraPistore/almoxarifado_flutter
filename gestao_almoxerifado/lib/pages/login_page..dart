import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  String fakeUser = "admin@email.com";
  String fakePass = "123456";

  void login() {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Preencha todos os campos')));
      return;
    } else if (email != fakeUser || senha != fakePass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha ou email invalido(s)')),
      );
      return;
    } else {
      Navigator.of(context).pushNamed('/home');
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green, 
                const Color.fromARGB(255, 2, 65, 4),
              ],
            ),
          ),
        child: Center(
          child: SingleChildScrollView(
            
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bem-vindo(a)', 
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                       'Faça login para continuar',
                       style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 231, 231, 231),
                        ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 5,
                      color: const Color.fromARGB(255, 240, 246, 239),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: emailController,
                              onSubmitted: (null),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                                ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: senhaController,
                              onSubmitted: (null),
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                ),
                              obscureText: true,
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ElevatedButton(
                                  child: Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                                  ),
                                  onPressed: login,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
