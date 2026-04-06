import 'package:flutter/material.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    //painel de navegação
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Gerente'), //temporário
            accountEmail: Text('gerent.com'), //temporário
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://www.elmueble.com/medio/2022/06/16/gato-comun-europeo_00000000_230418105437_900x900.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ), //temporário
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.of(context).pushNamed('/home'),
            ),

          ListTile(
            leading: Icon(Icons.inventory_2),
            title: Text('Estoque'),
            onTap: () => Navigator.of(context).pushNamed('/estoque'),
            ),

          ListTile(
            leading: Icon(Icons.sync_alt),
            title: Text('Movimentações'),
            onTap: () => Navigator.of(context).pushNamed('/movimentacao') ,
        
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () => Navigator.of(context).pushNamed('/configuracoes'),
            ),
        ],
      ),
    );
  }
}
