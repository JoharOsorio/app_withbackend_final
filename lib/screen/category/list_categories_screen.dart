import 'package:app_withbackend_final/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        actions: [
          IconButton(
              onPressed: () =>{},// Navigator.pushNamed(context, 'edit_category'),
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // categoryService.selectCategories =
              //     categoryService.categories[index];
              // Navigator.pushNamed(context, 'edit_category');
            },
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.category),
                title: Text(
                    categoryService.categories[index].categoryName),
                subtitle: Text(
                    'State: ${categoryService.categories[index].categoryState}'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
