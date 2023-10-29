import 'package:app_withbackend_final/theme/theme.dart';
import 'package:app_withbackend_final/providers/product_form_provider.dart';
import 'package:app_withbackend_final/services/product_service.dart';
import 'package:app_withbackend_final/ui/input_decorations.dart';
import 'package:app_withbackend_final/widgets/product_image.dart';
import 'package:provider/provider.dart';


class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectProduct!),
        child: _ProductScreenBody(
          productService: productService,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.selectProduct!.productImage,
              ),
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
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.deleteProduct(productForm.products, context);
            },
            heroTag: null,
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(productForm.products);
            },
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.products;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'name cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Product Name',
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: '-----',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
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
