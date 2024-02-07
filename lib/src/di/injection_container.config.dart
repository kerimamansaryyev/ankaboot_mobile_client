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
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../core/di/injection_module.dart' as _i24;
import '../core/navigation/app_navigator.dart' as _i5;
import '../features/ams_apis/data/repository_impls/mock_ams_apis_repository.dart'
    as _i4;
import '../features/ams_apis/domain/repositories/ams_apis_repository.dart'
    as _i3;
import '../features/ams_apis/domain/use_cases/change_status_ams_api_entity.dart'
    as _i6;
import '../features/ams_apis/domain/use_cases/get_ams_api_entities.dart' as _i7;
import '../features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart'
    as _i15;
import '../features/ams_apis/presentation/stores/global_ams_api_status_change_store.dart'
    as _i8;
import '../features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart'
    as _i10;
import '../features/home/presentation/blocs/home_page_tab_bloc.dart' as _i11;
import '../features/home/presentation/home_navigator.dart' as _i9;
import '../features/home/presentation/pages/home_page/home_page_model.dart'
    as _i22;
import '../features/home/presentation/pages/home_page/home_page_presenter.dart'
    as _i23;
import '../features/settings/data/repository_impls/language_repository_impl.dart'
    as _i17;
import '../features/settings/data/repository_impls/theme_repository_impl.dart'
    as _i14;
import '../features/settings/domain/repositories/language_repository.dart'
    as _i16;
import '../features/settings/domain/repositories/theme_repository.dart' as _i13;
import '../features/settings/domain/use_cases/load_settings.dart' as _i18;
import '../features/settings/domain/use_cases/save_language.dart' as _i19;
import '../features/settings/domain/use_cases/save_theme.dart' as _i20;
import '../features/settings/presentation/stores/global_settings_store.dart'
    as _i21;

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
  gh.factory<_i6.ChangeStatusAMSAPIEntity>(
      () => _i6.ChangeStatusAMSAPIEntity(gh<_i3.AMSAPIsRepository>()));
  gh.factory<_i7.GetAMSAPIEntities>(
      () => _i7.GetAMSAPIEntities(gh<_i3.AMSAPIsRepository>()));
  gh.lazySingleton<_i8.GlobalAMSAPIStatusChangeStore>(() =>
      _i8.GlobalAMSAPIStatusChangeStore(gh<_i6.ChangeStatusAMSAPIEntity>()));
  gh.factory<_i9.HomeNavigator>(
      () => _i9.HomeNavigator(appNavigator: gh<_i5.AppNavigator>()));
  gh.factory<_i10.HomePageAMSAPIFilterBloc>(
      () => _i10.HomePageAMSAPIFilterBloc());
  gh.factory<_i11.HomePageTabBloc>(() => _i11.HomePageTabBloc());
  await gh.lazySingletonAsync<_i12.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i13.ThemeRepository>(
      () => _i14.ThemeRepositoryImpl(gh<_i12.SharedPreferences>()));
  gh.factory<_i15.FetchAMSAPIsBloc>(
      () => _i15.FetchAMSAPIsBloc(gh<_i7.GetAMSAPIEntities>()));
  gh.lazySingleton<_i16.LanguageRepository>(
      () => _i17.LanguageRepositoryImpl(gh<_i12.SharedPreferences>()));
  gh.factory<_i18.LoadSettings>(() => _i18.LoadSettings(
        gh<_i13.ThemeRepository>(),
        gh<_i16.LanguageRepository>(),
      ));
  gh.factory<_i19.SaveLanguage>(
      () => _i19.SaveLanguage(gh<_i16.LanguageRepository>()));
  gh.factory<_i20.SaveTheme>(() => _i20.SaveTheme(gh<_i13.ThemeRepository>()));
  await gh.lazySingletonAsync<_i21.GlobalSettingsStore>(
    () => _i21.GlobalSettingsStore.internalInit(
      gh<_i18.LoadSettings>(),
      gh<_i19.SaveLanguage>(),
      gh<_i20.SaveTheme>(),
    ),
    preResolve: true,
  );
  gh.factory<_i22.HomePageModel>(() => _i22.HomePageModel(
        gh<_i21.GlobalSettingsStore>(),
        gh<_i11.HomePageTabBloc>(),
        gh<_i15.FetchAMSAPIsBloc>(),
        gh<_i10.HomePageAMSAPIFilterBloc>(),
        gh<_i8.GlobalAMSAPIStatusChangeStore>(),
      ));
  gh.factory<_i23.HomePagePresenter>(
      () => _i23.HomePagePresenter(gh<_i22.HomePageModel>()));
  return getIt;
}

class _$InjectionModule extends _i24.InjectionModule {}
