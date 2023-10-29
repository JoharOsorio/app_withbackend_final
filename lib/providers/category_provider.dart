import 'package:flutter/material.dart';
import 'package:app_withbackend_final/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ListCategories categories;
  CategoryProvider(this.categories);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
