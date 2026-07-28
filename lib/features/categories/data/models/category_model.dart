import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;
  final String slug;
  final String image;
  final bool isActive;
  final String? createdAt;

  const CategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.slug,
    required this.image,
    this.isActive = true,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'slug': slug,
      'image': image,
      'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [id];
}
