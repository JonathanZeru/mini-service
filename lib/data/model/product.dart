class ProductVariation {
  final String id;
  final String name;
  final Map<String, dynamic> attributes; // e.g., {'color': 'Red', 'size': 'XL'}
  final double price;
  final int stockCount;
  final List<String> images;

  ProductVariation({
    required this.id,
    required this.name,
    required this.attributes,
    required this.price,
    required this.stockCount,
    required this.images,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      id: json['id'] as String,
      name: json['name'] as String,
      attributes: Map<String, dynamic>.from(
        json['attributes'] as Map<String, dynamic>,
      ),
      price: (json['price'] as num).toDouble(),
      stockCount: json['stockCount'] as int,
      images: List<String>.from(json['images'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'attributes': attributes,
      'price': price,
      'stockCount': stockCount,
      'images': images,
    };
  }
}

class ProductReview {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> images;
  final List<ProductReviewComment> replies;
  final bool isVerifiedPurchase;

  ProductReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    this.images = const [],
    this.replies = const [],
    this.isVerifiedPurchase = false,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
      images: List<String>.from(json['images'] as List<dynamic>? ?? []),
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map(
                (reply) => ProductReviewComment.fromJson(
                  reply as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'images': images,
      'replies': replies.map((reply) => reply.toJson()).toList(),
      'isVerifiedPurchase': isVerifiedPurchase,
    };
  }
}

class ProductReviewComment {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String comment;
  final DateTime date;
  final bool isSellerResponse;

  ProductReviewComment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.comment,
    required this.date,
    this.isSellerResponse = false,
  });

  factory ProductReviewComment.fromJson(Map<String, dynamic> json) {
    return ProductReviewComment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
      isSellerResponse: json['isSellerResponse'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'comment': comment,
      'date': date.toIso8601String(),
      'isSellerResponse': isSellerResponse,
    };
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price; // Base price
  final double originalPrice;
  final String image; // Main image
  final List<String> images; // All product images
  final String categoryId;
  final String ageGroup;
  final double rating;
  final int reviewCount;
  final int stockCount;
  final bool isNew;
  final bool freeShipping;
  bool isFavorite;

  // Alibaba-style marketplace attributes
  final String sellerId;
  final String sellerName;
  final double sellerRating;
  final int minOrderQuantity;
  final List<ProductVariation> variations;
  final List<ProductReview> reviews;
  final Map<String, List<String>>
  availableAttributes; // e.g., {'color': ['Red', 'Blue'], 'size': ['S', 'M', 'L']}
  final bool hasWholesalePricing;
  final Map<int, double>
  bulkPricing; // e.g., {10: 95.0, 50: 90.0, 100: 85.0} - quantity: price per unit
  final String origin;
  final int leadTimeInDays;
  final bool customizationAvailable;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    this.originalPrice = 0,
    required this.image,
    this.images = const [],
    required this.categoryId,
    this.ageGroup = 'For All',
    this.rating = 0,
    this.reviewCount = 0,
    this.stockCount = 100,
    this.isNew = false,
    this.freeShipping = false,
    this.isFavorite = false,
    this.sellerId = '',
    this.sellerName = '',
    this.sellerRating = 0,
    this.minOrderQuantity = 1,
    this.variations = const [],
    this.reviews = const [],
    this.availableAttributes = const {},
    this.hasWholesalePricing = false,
    this.bulkPricing = const {},
    this.origin = '',
    this.leadTimeInDays = 7,
    this.customizationAvailable = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble() ?? 0,
      image: json['image'] as String,
      images: List<String>.from(json['images'] as List<dynamic>? ?? []),
      categoryId: json['categoryId'] as String,
      ageGroup: json['ageGroup'] as String? ?? 'For All',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      stockCount: json['stockCount'] as int? ?? 100,
      isNew: json['isNew'] as bool? ?? false,
      freeShipping: json['freeShipping'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      sellerId: json['sellerId'] as String? ?? '',
      sellerName: json['sellerName'] as String? ?? '',
      sellerRating: (json['sellerRating'] as num?)?.toDouble() ?? 0,
      minOrderQuantity: json['minOrderQuantity'] as int? ?? 1,
      variations:
          (json['variations'] as List<dynamic>?)
              ?.map(
                (variation) => ProductVariation.fromJson(
                  variation as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map(
                (review) =>
                    ProductReview.fromJson(review as Map<String, dynamic>),
              )
              .toList() ??
          [],
      availableAttributes:
          (json['availableAttributes'] as Map<String, dynamic>?)?.map(
            (key, value) =>
                MapEntry(key, List<String>.from(value as List<dynamic>)),
          ) ??
          {},
      hasWholesalePricing: json['hasWholesalePricing'] as bool? ?? false,
      bulkPricing:
          (json['bulkPricing'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(int.parse(key), (value as num).toDouble()),
          ) ??
          {},
      origin: json['origin'] as String? ?? '',
      leadTimeInDays: json['leadTimeInDays'] as int? ?? 7,
      customizationAvailable: json['customizationAvailable'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'image': image,
      'images': images,
      'categoryId': categoryId,
      'ageGroup': ageGroup,
      'rating': rating,
      'reviewCount': reviewCount,
      'stockCount': stockCount,
      'isNew': isNew,
      'freeShipping': freeShipping,
      'isFavorite': isFavorite,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'sellerRating': sellerRating,
      'minOrderQuantity': minOrderQuantity,
      'variations': variations.map((variation) => variation.toJson()).toList(),
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'availableAttributes': availableAttributes,
      'hasWholesalePricing': hasWholesalePricing,
      'bulkPricing': bulkPricing.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
      'origin': origin,
      'leadTimeInDays': leadTimeInDays,
      'customizationAvailable': customizationAvailable,
    };
  }

  // Get price based on quantity (for bulk pricing)
  double getPriceForQuantity(int quantity) {
    if (!hasWholesalePricing || bulkPricing.isEmpty) {
      return price;
    }

    // Sort bulk pricing thresholds in descending order
    final thresholds =
        bulkPricing.keys.toList()..sort((a, b) => b.compareTo(a));

    // Find the applicable threshold
    for (final threshold in thresholds) {
      if (quantity >= threshold) {
        return bulkPricing[threshold]!;
      }
    }

    return price;
  }

  // Get variation by ID
  ProductVariation? getVariationById(String variationId) {
    try {
      return variations.firstWhere((variation) => variation.id == variationId);
    } catch (e) {
      return null;
    }
  }
}
