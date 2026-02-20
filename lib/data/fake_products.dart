import '../models/product.dart';

class FakeProducts {
  static List<Product> farmerProducts = [
    Product(
      id: 1,
      name: 'Pomme de terre',
      price: 600,
      priceKg: 550,
      category: 'Légumes',
      location: 'Village A',
      quantity: 30,
      imageUrl: 'assets/images/pomme_de_terre.jpg',
    ),
    Product(
      id: 2,
      name: 'Maïs',
      price: 600,
      priceKg: 600,
      category: 'Céréales',
      location: 'Village B',
      quantity: 0,
      imageUrl: 'assets/images/mais.jpg',
    ),
    Product(
      id: 3,
      name: 'Carotte',
      price: 600,
      priceKg: 250,
      category: 'Légumes',
      location: 'Village A',
      quantity: 30,
      imageUrl: 'assets/images/carotte.jpg',
    ),
    Product(
      id: 4,
      name: 'Maïs',
      price: 600,
      priceKg: 120,
      category: 'Céréales',
      location: 'Village B',
      quantity: 0,
      imageUrl: 'assets/images/mais.jpg',
    ),
    Product(
      id: 5,
      name: 'Haricot blanc',
      price: 600,
      priceKg: 1500,
      category: 'Céréales',
      location: 'Village A',
      quantity: 30,
      imageUrl: 'assets/images/haricot_blanc.jpg',
    ),
    Product(
      id: 6,
      name: 'Oignon',
      price: 600,
      priceKg: 700,
      category: 'Légumes',
      location: 'Village A',
      quantity: 70,
      imageUrl: 'assets/images/oignons.png',
    ),
  ];
}

