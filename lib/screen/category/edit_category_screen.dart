import 'package:app_withbackend_final/theme/theme.dart';
import 'package:app_withbackend_final/providers/category_provider.dart';
import 'package:app_withbackend_final/services/category_service.dart';
import 'package:provider/provider.dart';
import 'package:app_withbackend_final/ui/input_decorations.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryProvider(productService.selectCategories!),
        child: _CategoryScreenBody(
          productService: productService,
        ));
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final CategoryService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          _CategoryForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              // await productService.deleteProduct(productForm.product, context);
            },
            heroTag: null,
            child: const Icon(Icons.delete_forever),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              // await productService.editOrCreateProduct(productForm.product);
            },
            heroTag: null,
            child: const Icon(Icons.save_alt_outlined),
          ),
        ],
      ),
    );
  }
}

class _CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<CategoryProvider>(context);
    final product = productForm.categories;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        // decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.categoryName,
                onChanged: (value) => product.categoryName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name cannot be empty';
                  }
                  return null;
                },
                // decoration: InputDecortions.authInputDecoration(
                //   hinText: 'Product Name',
                //   labelText: 'Name',
                // ),
              ),
              // const SizedBox(height: 20),
              // TextFormField(
              //   keyboardType: TextInputType.number,
              //   initialValue: product.productPrice.toString(),
              //   onChanged: (value) {
              //     if (int.tryParse(value) == null) {
              //       product.productPrice = 0;
              //     } else {
              //       product.productPrice = int.parse(value);
              //     }
              //   },
              //   decoration: InputDecortions.authInputDecoration(
              //     hinText: '-----',
              //     labelText: 'Precio',
              //   ),
              // ),
              // const SizedBox(height: 20),
              // SwitchListTile.adaptive(
              //   value: true,
              //   onChanged: (value) {},
              //   activeColor: MyTheme.primary,
              //   title: const Text('Disponible'),
              // )
            ],
          ),
        ),
      ),
    );
  }

  // BoxDecoration _createDecoration() => const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.only(
  //             bottomLeft: Radius.circular(25),
  //             bottomRight: Radius.circular(25)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black,
  //             offset: Offset(0, 5),
  //             blurRadius: 10,
  //           )
  //         ]);
}
