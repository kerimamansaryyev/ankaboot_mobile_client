import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';

abstract interface class LanguageRepository {
  Future<Either<Failure, AppLanguage>> getLanguage();
  Future<Either<Failure, void>> saveLanguage(AppLanguage language);
}
