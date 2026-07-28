import 'package:equatable/equatable.dart';
import 'package:rahala/features/categories/data/models/category_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesFailure extends CategoriesState {
  final String message;

  const CategoriesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
