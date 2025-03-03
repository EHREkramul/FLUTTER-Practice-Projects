import 'package:flutter/material.dart';
import 'package:simple_crud_app/models/productmodel.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.onEdit,
    required this.onDelete,
    required this.product,
    super.key,
  });
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Data product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey,
            child:
                product.img != null && product.img!.isNotEmpty
                    ? Image.network(
                      product.img!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => Icon(Icons.broken_image),
                    )
                    : Icon(Icons.broken_image),
          ),
          Text(
            "${product.productName}",
            style: TextStyle(fontSize: 18),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "\$ ${product.unitPrice.toString()}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Stock: ${product.qty.toString()}",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
