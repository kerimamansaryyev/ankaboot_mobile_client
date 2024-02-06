import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_theme.dart';

abstract interface class ThemeRepository {
  Future<Either<Failure, AppTheme?>> getAppTheme();
  Future<Either<Failure, void>> saveAppTheme(AppTheme theme);
}
