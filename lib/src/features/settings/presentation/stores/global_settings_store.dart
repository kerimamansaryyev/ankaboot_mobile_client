import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_theme.dart';
import 'package:ankabootmobile/src/features/settings/domain/use_cases/load_settings.dart';
import 'package:ankabootmobile/src/features/settings/domain/use_cases/save_language.dart';
import 'package:ankabootmobile/src/features/settings/domain/use_cases/save_theme.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@lazySingleton
final class GlobalSettingsStore extends Cubit<GlobalSettingsState> {
  final SaveLanguage _saveLanguage;
  final SaveTheme _saveTheme;

  GlobalSettingsStore._(
    super.initialState,
    this._saveLanguage,
    this._saveTheme,
  );

  factory GlobalSettingsStore.fromEnv() =>
      serviceLocator<GlobalSettingsStore>();

  void setLanguage(AppLanguage language) {
    _saveLanguage(language);
    emit(
      state.copyWith(
        appLanguage: language,
      ),
    );
  }

  void setTheme(AppTheme theme) {
    _saveTheme(theme);
    emit(
      state.copyWith(
        appTheme: theme,
      ),
    );
  }

  @FactoryMethod(preResolve: true)
  static Future<GlobalSettingsStore> internalInit(
    LoadSettings loadSettings,
    SaveLanguage saveLanguage,
    SaveTheme saveTheme,
  ) async {
    final record = await loadSettings();

    return GlobalSettingsStore._(
      GlobalSettingsState(
        appTheme: record.theme,
        appLanguage: record.language,
      ),
      saveLanguage,
      saveTheme,
    );
  }
}

final class GlobalSettingsState {
  final AppTheme? appTheme;
  final AppLanguage appLanguage;

  const GlobalSettingsState({
    required this.appLanguage,
    required this.appTheme,
  });

  GlobalSettingsState copyWith({
    AppLanguage? appLanguage,
    AppTheme? appTheme,
    bool forceNullAppTheme = false,
  }) =>
      GlobalSettingsState(
        appLanguage: appLanguage ?? this.appLanguage,
        appTheme: forceNullAppTheme && appTheme == null
            ? null
            : (appTheme ?? this.appTheme),
      );
}
