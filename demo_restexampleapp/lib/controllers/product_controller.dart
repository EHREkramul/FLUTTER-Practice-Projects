import 'dart:convert';

import 'package:demo_restexampleapp/models/productmodel.dart';
import 'package:demo_restexampleapp/utils/urls.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductResponseModel productModel = ProductResponseModel.fromJson(data);

      products = productModel.data ?? [];
    }
  }

  Future<void> createProduct(
    String name,
    int qty,
    String img,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().millisecond,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );
  }
  
  Future<void> deleteProduct(String id) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));
  }

  Future<void> updateProduct(
    String id,
    String name,
    int qty,
    String img,
    int unitPrice,
    int totalPrice,
  ) async {
    final response = await http.post(
      Uri.parse(Urls.updateProduct(id)),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        // "ProductCode": DateTime.now().millisecond,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );
  }
}
