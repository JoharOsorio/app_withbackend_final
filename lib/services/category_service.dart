import 'package:app_withbackend_final/models/category.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ListCategories> categories = [];
  ListCategories? selectCategories;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategory();
  }
  Future loadCategory() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final categoriesMap = Category.fromJson(response.body);
    print(response.body);
    categories = categoriesMap.lisCategories;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreatecategory(ListCategories category) async {
    isEditCreate = true;
    notifyListeners();
    if (category.categoryId == 0) {
      await createcategory(category);
    } else {
      await updatecategory(category);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updatecategory(ListCategories category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    
    //actualizamos el listado
    final index = categories
        .indexWhere((element) => element.categoryId == category.categoryId);
    categories[index] = category;
    return '';
  }

  Future createcategory(ListCategories category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    categories.add(category);
    return '';
  }

  Future deletecategory(ListCategories category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    categories.clear(); //borra todo el listado
    loadCategory();
    Navigator.of(context).pushNamed('list_category');
    return '';
  }
}
