import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_theme.dart';
import 'package:ankabootmobile/src/features/settings/domain/repositories/theme_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ThemeRepository)
final class ThemeRepositoryImpl implements ThemeRepository {
  static const _themeKey = 'saved_app_theme';

  final SharedPreferences _sharedPreferences;

  ThemeRepositoryImpl(this._sharedPreferences);

  @override
  Future<Either<Failure, AppTheme?>> getAppTheme() async => Right(
        AppTheme.fromName(
          _sharedPreferences.getString(_themeKey) ?? '',
        ),
      );

  @override
  Future<Either<Failure, void>> saveAppTheme(AppTheme theme) =>
      _sharedPreferences
          .setString(
            _themeKey,
            theme.themeName,
          )
          .then<Either<Failure, void>>(
            (_) => const Right(null),
          )
          .catchError(
            (exception, trace) => Left(
              UnknownFailure(
                exception: ShallowException(exception),
                stackTrace: trace,
              ),
            ),
          );
}
