import 'package:flutter/material.dart';
import 'package:simple_crud_app/widgets/product_card.dart';

import 'controllers/product_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    await productController.fetchProducts();
    setState(() {});
  }
  void showProductDialogue(
    BuildContext context, {
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
        onPressed: () => showProductDialogue(context),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        elevation: 5,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: GridView.builder(
        itemCount: productController.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return ProductCard(
            product: product,
            onEdit: () {
              showProductDialogue(
                context,
                id: product.sId,
                img: product.img,
                name: product.productName,
                qty: product.qty,
                totalPrice: product.totalPrice,
                unitPrice: product.unitPrice,
              );
            },
            onDelete: () async {
              await productController.deleteProduct(product.sId.toString());
              await fetchData();
            },
          );
        },
      ),
    );
  }
}
