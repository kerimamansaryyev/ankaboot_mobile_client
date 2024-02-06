// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../core/di/injection_module.dart' as _i22;
import '../core/navigation/app_navigator.dart' as _i5;
import '../features/ams_apis/data/repository_impls/mock_ams_apis_repository.dart'
    as _i4;
import '../features/ams_apis/domain/repositories/ams_apis_repository.dart'
    as _i3;
import '../features/ams_apis/domain/use_cases/get_ams_api_entities.dart' as _i6;
import '../features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart'
    as _i13;
import '../features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart'
    as _i8;
import '../features/home/presentation/blocs/home_page_tab_bloc.dart' as _i9;
import '../features/home/presentation/home_navigator.dart' as _i7;
import '../features/home/presentation/pages/home_page/home_page_model.dart'
    as _i20;
import '../features/home/presentation/pages/home_page/home_page_presenter.dart'
    as _i21;
import '../features/settings/data/repository_impls/language_repository_impl.dart'
    as _i15;
import '../features/settings/data/repository_impls/theme_repository_impl.dart'
    as _i12;
import '../features/settings/domain/repositories/language_repository.dart'
    as _i14;
import '../features/settings/domain/repositories/theme_repository.dart' as _i11;
import '../features/settings/domain/use_cases/load_settings.dart' as _i16;
import '../features/settings/domain/use_cases/save_language.dart' as _i17;
import '../features/settings/domain/use_cases/save_theme.dart' as _i18;
import '../features/settings/presentation/stores/global_settings_store.dart'
    as _i19;

const String _test = 'test';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.lazySingleton<_i3.AMSAPIsRepository>(
    () => _i4.MockAMSAPIsRepository(),
    registerFor: {_test},
  );
  gh.factory<_i5.AppNavigator>(() => _i5.AppNavigator());
  gh.factory<_i6.GetAMSAPIEntities>(
      () => _i6.GetAMSAPIEntities(gh<_i3.AMSAPIsRepository>()));
  gh.factory<_i7.HomeNavigator>(
      () => _i7.HomeNavigator(appNavigator: gh<_i5.AppNavigator>()));
  gh.factory<_i8.HomePageAMSAPIFilterBloc>(
      () => _i8.HomePageAMSAPIFilterBloc());
  gh.factory<_i9.HomePageTabBloc>(() => _i9.HomePageTabBloc());
  await gh.lazySingletonAsync<_i10.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i11.ThemeRepository>(
      () => _i12.ThemeRepositoryImpl(gh<_i10.SharedPreferences>()));
  gh.factory<_i13.FetchAMSAPIsBloc>(
      () => _i13.FetchAMSAPIsBloc(gh<_i6.GetAMSAPIEntities>()));
  gh.lazySingleton<_i14.LanguageRepository>(
      () => _i15.LanguageRepositoryImpl(gh<_i10.SharedPreferences>()));
  gh.factory<_i16.LoadSettings>(() => _i16.LoadSettings(
        gh<_i11.ThemeRepository>(),
        gh<_i14.LanguageRepository>(),
      ));
  gh.factory<_i17.SaveLanguage>(
      () => _i17.SaveLanguage(gh<_i14.LanguageRepository>()));
  gh.factory<_i18.SaveTheme>(() => _i18.SaveTheme(gh<_i11.ThemeRepository>()));
  await gh.lazySingletonAsync<_i19.GlobalSettingsStore>(
    () => _i19.GlobalSettingsStore.internalInit(
      gh<_i16.LoadSettings>(),
      gh<_i17.SaveLanguage>(),
      gh<_i18.SaveTheme>(),
    ),
    preResolve: true,
  );
  gh.factory<_i20.HomePageModel>(() => _i20.HomePageModel(
        gh<_i19.GlobalSettingsStore>(),
        gh<_i9.HomePageTabBloc>(),
        gh<_i13.FetchAMSAPIsBloc>(),
        gh<_i8.HomePageAMSAPIFilterBloc>(),
      ));
  gh.factory<_i21.HomePagePresenter>(
      () => _i21.HomePagePresenter(gh<_i20.HomePageModel>()));
  return getIt;
}

class _$InjectionModule extends _i22.InjectionModule {}
