import 'dio_error_language_entity.dart';

class DioErrorEntity implements Exception {
  final dynamic statusCode;
  final DioErrorLanguageEntity? errorLanguageEntity;

  const DioErrorEntity({required this.statusCode, this.errorLanguageEntity});
}
