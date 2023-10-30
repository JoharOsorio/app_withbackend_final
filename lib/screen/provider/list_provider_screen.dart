import 'package:app_withbackend_final/models/provider.dart';
import 'package:app_withbackend_final/services/provider_service.dart';
import 'package:app_withbackend_final/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProviderScreen extends StatelessWidget {
  const ListProviderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
        actions: [
          IconButton(
              onPressed: () => {
                providerService.selectproviders = ListProviders.empty(),
                Navigator.pushNamed(context, 'edit_provider')
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: providerService.providers.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              providerService.selectproviders =
                  providerService.providers[index];
              Navigator.pushNamed(context, 'edit_provider');
            },
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                    providerService.providers[index].providerName),
                subtitle: Text(
                    'State: ${providerService.providers[index].providerState}'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
