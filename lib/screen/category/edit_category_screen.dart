import 'package:app_withbackend_final/providers/category_provider.dart';
import 'package:app_withbackend_final/services/category_service.dart';
import 'package:app_withbackend_final/theme/theme.dart';
import 'package:app_withbackend_final/ui/input_decorations.dart';
import 'package:provider/provider.dart';


class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryProvider(categoryService.selectCategories!),
        child: _CategoryScreenBody(
          categoryService: categoryService,
        ));
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  final CategoryService categoryService;

  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryForm.categories.categoryName,
        ),
      ),
      body: _CategoryForm(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.deletecategory(categoryForm.categories, context);
              Navigator.of(context).pushNamed('list_category');
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.editOrCreatecategory(categoryForm.categories);
              Navigator.of(context).pushNamed('list_category');
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}


class _CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryProvider>(context);
    final category = categoryForm.categories;
    const categoryState = "Activa";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: categoryForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: category.categoryName,
                onChanged: (value) => category.categoryName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'category Name',
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: category.categoryState == categoryState ? true : false,
                onChanged: (value) {
                  if (value == true) {
                    category.categoryState = categoryState;
                  } else {
                    category.categoryState = "Inactiva";
                  }
                  categoryForm.updateCategory(category);
                },
                activeColor: MyTheme.primary,
                title: const Text('Disponible'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
