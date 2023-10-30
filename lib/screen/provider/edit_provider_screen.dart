import 'package:app_withbackend_final/providers/provider_provider.dart';
import 'package:app_withbackend_final/services/provider_service.dart';
import 'package:app_withbackend_final/theme/theme.dart';
import 'package:app_withbackend_final/ui/input_decorations.dart';
import 'package:provider/provider.dart';


class EditProviderScreen extends StatelessWidget {
  const EditProviderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProviderProvider(providerService.selectproviders!),
        child: _ProviderScreenBody(
          providerService: providerService,
        ));
  }
}

class _ProviderScreenBody extends StatelessWidget {
  const _ProviderScreenBody({
    Key? key,
    required this.providerService,
  }) : super(key: key);

  final ProviderService providerService;

  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          providerForm.providers.providerName,
        ),
      ),
      body: _ProviderForm(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!providerForm.isValidForm()) return;
              await providerService.deleteprovider(providerForm.providers, context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!providerForm.isValidForm()) return;
              await providerService.editOrCreateprovider(providerForm.providers);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}


class _ProviderForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderProvider>(context);
    final provider = providerForm.providers;
    const providerState = "Activa";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: providerForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: provider.providerName,
                onChanged: (value) => provider.providerName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'provider Name',
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: provider.providerState == providerState ? true : false,
                onChanged: (value) {
                  if (value == true) {
                    provider.providerState = providerState;
                  } else {
                    provider.providerState = "Inactiva";
                  }
                  providerForm.updateProvider(provider);
                },
                activeColor: MyTheme.primary,
                title: const Text('Disponible'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
