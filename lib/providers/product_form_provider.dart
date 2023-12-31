import 'package:flutter/material.dart';
import 'package:app_withbackend_final/models/producto.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Listado products;
  ProductFormProvider(this.products);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
