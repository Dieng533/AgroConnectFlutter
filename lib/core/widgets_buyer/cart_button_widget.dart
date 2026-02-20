import 'package:flutter/material.dart';

class CartButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final int itemCount;

  const CartButtonWidget({
    super.key,
    required this.onPressed,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.shopping_cart),
      label: Text('Panier ($itemCount)'),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
