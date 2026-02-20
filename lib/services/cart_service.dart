import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void addToCart(Product product) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
  }

  static double get total {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  static void clear() {
    _items.clear();
  }
}
