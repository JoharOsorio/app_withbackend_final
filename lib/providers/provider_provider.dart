import 'package:app_withbackend_final/models/provider.dart';
import 'package:flutter/material.dart';

class ProviderProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ListProviders providers;
  ProviderProvider(this.providers);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void updateProvider(ListProviders prov) {
    providers = providers;
    notifyListeners();
  }
}
