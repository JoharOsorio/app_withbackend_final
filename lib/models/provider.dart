import 'dart:convert';

class ProviderModel {
  ProviderModel({
    required this.listProviders,
  });

  List<ListProviders> listProviders;

  factory ProviderModel.fromJson(String str) => ProviderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProviderModel.fromMap(Map<String, dynamic> json) => ProviderModel(
        listProviders:
            List<ListProviders>.from(json["Proveedores Listado"].map((x) => ListProviders.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Proveedores Listado": List<dynamic>.from(listProviders.map((x) => x.toMap())),
      };
}

class ListProviders {
  ListProviders({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });
  ListProviders.empty()
      : providerId = 0,
        providerName = '',
        providerLastName = '',
        providerMail = '',
        providerState = 'Activa';
                
  int providerId;
  String providerName;
  String providerLastName;
  String providerMail;
  String providerState;

  factory ListProviders.fromJson(String str) => ListProviders.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListProviders.fromMap(Map<String, dynamic> json) => ListProviders(
        providerId: json["providerid"],
        providerName: json["provider_name"],
        providerLastName: json["provider_last_name"],
        providerMail: json["provider_mail"],
        providerState: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": providerId,
        "provider_name": providerName,
        "provider_last_name": providerLastName,
        "provider_mail": providerMail,
        "provider_state": providerState,
      };

  ListProviders copy() => ListProviders(
      providerId: providerId,
      providerName:providerName,
      providerLastName: providerLastName,
      providerMail: providerMail,
      providerState: providerState);
}
