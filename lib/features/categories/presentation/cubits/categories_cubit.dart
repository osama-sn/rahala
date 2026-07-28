import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/categories/data/repositories/categories_repository.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _repository;

  CategoriesCubit(this._repository) : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final result = await _repository.getCategories();
    result.fold(
      (failure) => emit(CategoriesFailure(failure.message)),
      (categories) => emit(CategoriesSuccess(categories)),
    );
  }
}
