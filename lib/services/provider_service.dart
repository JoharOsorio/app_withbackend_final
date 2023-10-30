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
    loadprovider();
  }
  Future loadprovider() async {
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

  Future editOrCreateprovider(ListProviders provider) async {
    isEditCreate = true;
    notifyListeners();
    if (provider.providerId == 0) {
      await createprovider(provider);
    } else {
      await updateprovider(provider);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateprovider(ListProviders provider) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = providers
        .indexWhere((element) => element.providerId == provider.providerId);
    providers[index] = provider;

    return '';
  }

  Future createprovider(ListProviders provider) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    providers.add(provider);
    return '';
  }

  Future deleteprovider(ListProviders provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    providers.clear(); //borra todo el listado
    loadprovider();
    Navigator.of(context).pushNamed('list_providers');
    return '';
  }
}
