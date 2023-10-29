import 'dart:convert';

class Provider {
  Provider({
    required this.listProviders,
  });

  List<ListProviders> listProviders;

  factory Provider.fromJson(String str) => Provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<String, dynamic> json) => Provider(
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
