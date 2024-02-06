import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';
import 'package:ankabootmobile/src/features/settings/domain/repositories/language_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LanguageRepository)
final class LanguageRepositoryImpl implements LanguageRepository {
  static const _langKey = 'saved_app_language';

  final SharedPreferences _sharedPreferences;

  const LanguageRepositoryImpl(this._sharedPreferences);

  @override
  Future<Either<Failure, AppLanguage>> getLanguage() async => Right(
        AppLanguage.fromLanguageCode(
          _sharedPreferences.getString(_langKey) ?? '',
        ),
      );

  @override
  Future<Either<Failure, void>> saveLanguage(AppLanguage language) =>
      _sharedPreferences
          .setString(
            _langKey,
            language.languageCode,
          )
          .then<Either<Failure, void>>((_) => const Right(null))
          .catchError(
            (ex, trace) => Left(
              UnknownFailure(
                exception: ShallowException(ex),
                stackTrace: trace,
              ),
            ),
          );
}
