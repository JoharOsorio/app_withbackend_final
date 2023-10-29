import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    //card to modulos
    body: 
    ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Productos'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, 'list_product'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorías'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, 'list_category'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.person_search),
            title: const Text('Proveedores'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, 'list_provider'),
          ),
        ),
      ],
    ),
    );
  }
}