import 'dart:convert';

class Category {
  Category({
    required this.lisCategories,
  });

  List<ListCategories> lisCategories;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        lisCategories:
            List<ListCategories>.from(json["Listado Categorias"].map((x) => ListCategories.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado Categorias": List<dynamic>.from(lisCategories.map((x) => x.toMap())),
      };
}

class ListCategories {
  ListCategories({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });
  ListCategories.empty()
      : categoryId = 0,
        categoryName = '',
        categoryState = 'Activa';
        
  int categoryId;
  String categoryName;
  String categoryState;

  factory ListCategories.fromJson(String str) => ListCategories.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListCategories.fromMap(Map<String, dynamic> json) => ListCategories(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
      };

  ListCategories copy() => ListCategories(
      categoryId: categoryId,
      categoryName: categoryName,
      categoryState: categoryState);
}
