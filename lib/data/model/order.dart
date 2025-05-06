enum OrderStatus { pending, delivered, cancelled, returned, refunded }

class Order {
  final String id;
  final String productName;
  final String imageUrl;
  final OrderStatus status;
  final String statusText;
  final String paymentMethod;
  bool isFavorite;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.status,
    required this.statusText,
    required this.paymentMethod,
    this.isFavorite = false,
    DateTime? orderDate,
  }) : orderDate = orderDate ?? DateTime.now();

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      productName: json['productName'] as String,
      imageUrl: json['imageUrl'] as String,
      status: OrderStatus.values.byName(json['status'] as String),
      statusText: json['statusText'] as String,
      paymentMethod: json['paymentMethod'] as String,
      isFavorite: json['isFavorite'] as bool,
      orderDate: DateTime.parse(json['orderDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'imageUrl': imageUrl,
      'status': status.name,
      'statusText': statusText,
      'paymentMethod': paymentMethod,
      'isFavorite': isFavorite,
      'orderDate': orderDate.toIso8601String(),
    };
  }
}
