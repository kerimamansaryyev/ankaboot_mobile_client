import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/settings_record.dart';
import 'package:ankabootmobile/src/features/settings/domain/repositories/language_repository.dart';
import 'package:ankabootmobile/src/features/settings/domain/repositories/theme_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadSettings {
  final ThemeRepository _themeRepository;
  final LanguageRepository _languageRepository;

  const LoadSettings(
    this._themeRepository,
    this._languageRepository,
  );

  Future<SettingsRecord> call() async => (
        theme: (await _themeRepository.getAppTheme()).tryGetRight(),
        language: (await _languageRepository.getLanguage()).tryGetRight() ??
            AppLanguage.fallback,
      );
}
