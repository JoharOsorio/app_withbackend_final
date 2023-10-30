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
            onPressed: () async {
              if (!providerForm.isValidForm()) return;
              await providerService.deleteprovider(providerForm.providers, context);
              Navigator.of(context).pushNamed('list_provider');
            },
            heroTag: null,
            child: const Icon(Icons.delete_forever),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () async {
              if (!providerForm.isValidForm()) return;
              await providerService.editOrCreateprovider(providerForm.providers);
              Navigator.pushNamed(context, 'list_provider');
            },
            heroTag: null,
            child: const Icon(Icons.save_alt_outlined),
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
    const providerState2 = "Activo";

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
              TextFormField(
                initialValue: provider.providerLastName,
                onChanged: (value) => provider.providerLastName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Last Name Address',
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: provider.providerMail,
                onChanged: (value) => provider.providerMail = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mail cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'provider Mail',
                  labelText: 'Mail',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: provider.providerState == providerState || provider.providerState == providerState2,
                onChanged: (value) {
                  if (value == true) {
                    provider.providerState = providerState;
                    print(provider.providerState);
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
