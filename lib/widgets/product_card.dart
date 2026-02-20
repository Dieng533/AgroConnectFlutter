import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: product.isSoldOut ? null : onTap,
        child: Row(
          children: [
            // ============ IMAGE ============
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(14),
                  ),
                  child: Image.asset(
                    product.imageUrl,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product.isSoldOut)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      alignment: Alignment.center,
                      child: const Text(
                        'SOLD OUT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // ============ INFOS ============
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${product.category} • ${product.location}'),
                    const SizedBox(height: 6),

                    Text(
                      '${product.priceKg} f / kg',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 6),
                    Text(
                      product.isSoldOut
                          ? 'Stock épuisé'
                          : 'Restant : ${product.quantity} kg',
                      style: TextStyle(
                        color: product.isSoldOut
                            ? Colors.red
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


