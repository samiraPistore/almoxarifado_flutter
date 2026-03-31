import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Column(
        children: [
          TextField(
            controller: textController,
            onSubmitted: (null),
            decoration: InputDecoration(
              labelText: 'Email'
            ),
          ),
          TextField(
            controller: textController,
            onSubmitted: (null),
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:<Widget> [
              ElevatedButton(
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: () => Navigator.of(context).pushNamed('/home')
              ),
            ],
          ),
        ],
      ),
    );
  }
}