import 'package:flutter/material.dart';
import 'package:gestao_almoxerifado/components/navigatorBar.dart';

class Movimentacao extends StatelessWidget {
  const Movimentacao({super.key});

 
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      drawer: NavBar(), //chama o menu do arquvo NavigatorBar.dart
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Movimentações'),
      ),
      body: Center(
       
        child: Column(
        
          mainAxisAlignment: .center,
          children: [
            const Text('movimentações test'),
          ],
        ),
      ),
    
    );
  }
}