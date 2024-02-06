import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_theme.dart';
import 'package:ankabootmobile/src/features/settings/domain/repositories/theme_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTheme {
  final ThemeRepository _themeRepository;

  const SaveTheme(this._themeRepository);

  Future<Either<Failure, void>> call(AppTheme theme) =>
      _themeRepository.saveAppTheme(
        theme,
      );
}
