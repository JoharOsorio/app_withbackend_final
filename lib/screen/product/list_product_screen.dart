import 'package:app_withbackend_final/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:app_withbackend_final/models/producto.dart';
import 'package:app_withbackend_final/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:app_withbackend_final/screen/screen.dart';

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            productService.selectProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'edit_product');
          },
          child: ProductCard(product: productService.products[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.selectProduct = Listado(
              productId: 0,
              productName: '',
              productPrice: 0,  
              productImage:
                  'https://abravidro.org.br/wp-content/uploads/2015/04/sem-imagem4.jpg',
              productState: '');
          Navigator.pushNamed(context, 'edit_product');
        },
      ),
    );
  }
}
