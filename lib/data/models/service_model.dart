class ServiceModel {
  final String? id;
  final String name;
  final String categoryId;
  final double price;
  final String? imageUrl;
  final bool availability;
  final int duration;
  final double rating;
  final DateTime createdAt;

  ServiceModel({
    this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    this.imageUrl,
    required this.availability,
    required this.duration,
    required this.rating,
    required this.createdAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      price:
          (json['price'] is int)
              ? (json['price'] as int).toDouble()
              : double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'] as String?,
      availability:
          json['availability'] is bool
              ? json['availability'] as bool
              : json['availability'].toString().toLowerCase() == 'true',
      duration:
          json['duration'] is int
              ? json['duration'] as int
              : int.parse(json['duration'].toString()),
      rating:
          (json['rating'] is int)
              ? (json['rating'] as int).toDouble()
              : double.parse(json['rating'].toString()),
      createdAt:
          json['createdAt'] is DateTime
              ? json['createdAt'] as DateTime
              : DateTime.parse(json['createdAt'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'price': price,
      'imageUrl': imageUrl,
      'availability': availability,
      'duration': duration,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ServiceModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    double? price,
    String? imageUrl,
    bool? availability,
    int? duration,
    double? rating,
    DateTime? createdAt,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      availability: availability ?? this.availability,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
