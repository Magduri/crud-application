import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module13_class1/models/product.dart';
import 'package:module13_class1/ui/screens/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? '',
        width: 40,
      ),
      title: Text(product.productName ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? ''}'),
          Text('Quantity:${product.quantity ?? ''}'),
          Text('Price: ${product.unitPrice ?? ''}'),
          Text('Total Price: ${product.totalPrice ?? ''}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () {
                _deleteProduct(product, context);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, UpdateProductScreen.name,
                  arguments: product);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }

  Future<Response> _deleteProduct(product, context) async {
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${product.id}');
    //print(uri.toString());
    Response response = await get(
      uri,
      headers: {
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been deleted!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete product! Try again'),
        ),
      );
    }
    return response;
  }
}
