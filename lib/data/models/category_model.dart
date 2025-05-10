class CategoryModel {
  final String? id;
  final String name;
  final String description;
  final String? imageUrl;
  final List<String> listOfService;
  final DateTime createdAt;

  CategoryModel({
    this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.listOfService = const [],
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      listOfService: List<String>.from((json['listOfService'] as Iterable<dynamic>?) ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'listOfService': listOfService,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}