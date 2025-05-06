import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final Color color;
  bool isExpanded;
  final List<dynamic> children; // New field from API
  final String shortName; // New field from API
  final String description; // New field from API
  final List<dynamic> ancestor; // New field from API
  final List<dynamic> descendant; // New field from API
  final String createdBy; // New field from API
  final String? updatedBy; // New field from API
  final String slug; // New field from API
  final String iconName; // New field from API
  final bool isActive; // New field from API

  Category({
    this.id = '',
    this.name = '',
    this.image = '',
    this.color = Colors.transparent,
    this.isExpanded = false,
    this.children = const [],
    this.shortName = '',
    this.description = '',
    this.ancestor = const [],
    this.descendant = const [],
    this.createdBy = '',
    this.updatedBy,
    this.slug = '',
    this.iconName = '',
    this.isActive = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['iconName'] as String? ?? '', // Map 'iconName' to 'image'
      color:
          json['color'] != null
              ? Color(int.parse(json['color'] as String))
              : Colors.transparent, // Default to transparent if not provided
      isExpanded:
          json['isExpanded'] as bool? ??
          false, // Default to false if not provided
      children:
          json['children'] as List<dynamic>? ??
          [], // Default to empty list if not provided
      shortName:
          json['shortName'] as String? ??
          '', // Default to empty string if not provided
      description:
          json['description'] as String? ??
          '', // Default to empty string if not provided
      ancestor:
          json['ancestor'] as List<dynamic>? ??
          [], // Default to empty list if not provided
      descendant:
          json['descendant'] as List<dynamic>? ??
          [], // Default to empty list if not provided
      createdBy:
          json['createdBy'] as String? ??
          '', // Default to empty string if not provided
      updatedBy: json['updatedBy'] as String?, // Can be null
      slug:
          json['slug'] as String? ??
          '', // Default to empty string if not provided
      iconName:
          json['iconName'] as String? ??
          '', // Default to empty string if not provided
      isActive:
          json['isActive'] as bool? ??
          false, // Default to false if not provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': image,
      'color': color.toString(),
      'isExpanded': isExpanded,
      'children': children,
      'shortName': shortName,
      'description': description,
      'ancestor': ancestor,
      'descendant': descendant,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'slug': slug,
      'iconName': iconName,
      'isActive': isActive,
    };
  }
}
