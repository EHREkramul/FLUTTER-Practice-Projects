import 'package:flutter/material.dart';

import 'controllers/product_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductController productController = ProductController();

  Future<void> fetchData() async {
    await productController.fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _showProductDialogue({
    String? id,
    String? name,
    int? qty,
    String? img,
    int? unitPrice,
    int? totalPrice,
  }) {
    // Controllers
    TextEditingController productNameController = TextEditingController(
      text: name ?? "",
    );
    TextEditingController productImageController = TextEditingController(
      text: img ?? "",
    );
    TextEditingController productQtyController = TextEditingController(
      text: qty == null ? "" : qty.toString(),
    );
    TextEditingController productUnitPriceController = TextEditingController(
      text: unitPrice == null ? "" : unitPrice.toString(),
    );
    TextEditingController productTotalPriceController = TextEditingController(
      text: totalPrice == null ? "" : totalPrice.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(id == null ? 'Add Product' : 'Update Product'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: productImageController,
                    decoration: InputDecoration(
                      labelText: 'Product Image',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: productQtyController,
                    decoration: InputDecoration(
                      labelText: 'Product Qty',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: productUnitPriceController,
                    decoration: InputDecoration(
                      labelText: 'Product Unit Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: productTotalPriceController,
                    decoration: InputDecoration(
                      labelText: 'Product Total Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (productNameController.text.isEmpty ||
                              productQtyController.text.isEmpty ||
                              productUnitPriceController.text.isEmpty ||
                              productTotalPriceController.text.isEmpty) {
                            return;
                          }

                          if (id == null) {
                            // Add product
                            await productController.createProduct(
                              productNameController.text,
                              int.parse(productQtyController.text),
                              productImageController.text,
                              int.parse(productUnitPriceController.text),
                              int.parse(productTotalPriceController.text),
                            );
                          } else {
                            // Update product
                            await productController.updateProduct(
                              id,
                              productNameController.text,
                              int.parse(productQtyController.text),
                              productImageController.text,
                              int.parse(productUnitPriceController.text),
                              int.parse(productTotalPriceController.text),
                            );
                          }

                          // Fetch the updated list and refresh UI
                          await fetchData();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          id == null ? 'Add Product' : 'Update Product',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialogue(),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        elevation: 5,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(),
              title: Text(product.productName.toString()),
              subtitle: Text(
                'Price: \$${product.unitPrice} | Qty: ${product.qty}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed:
                        () => _showProductDialogue(
                          id: product.sId,
                          img: product.img,
                          name: product.productName,
                          qty: product.qty,
                          totalPrice: product.totalPrice,
                          unitPrice: product.unitPrice,
                        ),
                    icon: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      await productController.deleteProduct(product.sId!);
                      await fetchData();
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
