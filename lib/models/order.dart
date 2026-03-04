class Order {
  final int id;
  final double total;
  final String status;

  Order({
    required this.id,
    required this.total,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      total: double.parse(json['total'].toString()),
      status: json['status'],
    );
  }
}