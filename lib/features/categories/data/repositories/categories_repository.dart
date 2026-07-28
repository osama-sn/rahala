import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:rahala/features/categories/data/models/category_model.dart';

class CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoriesRepository(this._remoteDataSource);

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
