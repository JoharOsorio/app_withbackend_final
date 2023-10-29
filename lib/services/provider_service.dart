import 'package:app_withbackend_final/models/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ListProviders> providers = [];
  ListProviders? selectproviders;
  bool isLoading = true;
  bool isEditCreate = true;

  ProviderService() {
    loadCategory();
  }
  Future loadCategory() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final providersMap = Provider.fromJson(response.body);
    print(response.body);
    providers = providersMap.listProviders;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreatecategory(ListProviders category) async {
    isEditCreate = true;
    notifyListeners();
    if (category.providerId == 0) {
      await createcategory(category);
    } else {
      await updatecategory(category);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updatecategory(ListProviders category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = providers
        .indexWhere((element) => element.providerId == category.providerId);
    providers[index] = category;

    return '';
  }

  Future createcategory(ListProviders category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    providers.add(category);
    return '';
  }

  Future deletecategory(ListProviders category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    providers.clear(); //borra todo el listado
    loadCategory();
    Navigator.of(context).pushNamed('list_providers');
    return '';
  }
}
