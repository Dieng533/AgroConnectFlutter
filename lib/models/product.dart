class Product {
  final int id;
  final String name;

  // ANCIEN (pour compatibilité)
  final double price;

  // NOUVEAUX CHAMPS
  final double priceKg;
  final String category;
  final String location;
  final int quantity;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,       // ← IMPORTANT
    required this.priceKg,
    required this.category,
    required this.location,
    required this.quantity,
    required this.imageUrl,
  });

  bool get isSoldOut => quantity <= 0;
}

