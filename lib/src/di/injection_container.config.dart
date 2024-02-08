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
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import '../core/di/injection_module.dart' as _i30;
import '../core/navigation/app_navigator.dart' as _i5;
import '../core/presentation/blocs/global_interpage_conversation_bloc.dart'
    as _i10;
import '../features/ams_apis/data/repository_impls/mock_ams_apis_repository.dart'
    as _i4;
import '../features/ams_apis/domain/repositories/ams_apis_repository.dart'
    as _i3;
import '../features/ams_apis/domain/use_cases/change_status_ams_api_entity.dart'
    as _i6;
import '../features/ams_apis/domain/use_cases/create_ams_api_entity.dart'
    as _i7;
import '../features/ams_apis/domain/use_cases/get_ams_api_entities.dart' as _i8;
import '../features/ams_apis/presentation/ams_apis_navigator.dart' as _i17;
import '../features/ams_apis/presentation/blocs/create_ams_api_bloc.dart'
    as _i18;
import '../features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart'
    as _i21;
import '../features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_model.dart'
    as _i19;
import '../features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_presenter.dart'
    as _i20;
import '../features/ams_apis/presentation/stores/global_ams_api_status_change_store.dart'
    as _i9;
import '../features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart'
    as _i12;
import '../features/home/presentation/blocs/home_page_tab_bloc.dart' as _i13;
import '../features/home/presentation/home_navigator.dart' as _i11;
import '../features/home/presentation/pages/home_page/home_page_model.dart'
    as _i28;
import '../features/home/presentation/pages/home_page/home_page_presenter.dart'
    as _i29;
import '../features/settings/data/repository_impls/language_repository_impl.dart'
    as _i23;
import '../features/settings/data/repository_impls/theme_repository_impl.dart'
    as _i16;
import '../features/settings/domain/repositories/language_repository.dart'
    as _i22;
import '../features/settings/domain/repositories/theme_repository.dart' as _i15;
import '../features/settings/domain/use_cases/load_settings.dart' as _i24;
import '../features/settings/domain/use_cases/save_language.dart' as _i25;
import '../features/settings/domain/use_cases/save_theme.dart' as _i26;
import '../features/settings/presentation/stores/global_settings_store.dart'
    as _i27;

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
  gh.factory<_i7.CreateAMSAPIEntity>(
      () => _i7.CreateAMSAPIEntity(gh<_i3.AMSAPIsRepository>()));
  gh.factory<_i8.GetAMSAPIEntities>(
      () => _i8.GetAMSAPIEntities(gh<_i3.AMSAPIsRepository>()));
  gh.lazySingleton<_i9.GlobalAMSAPIStatusChangeStore>(() =>
      _i9.GlobalAMSAPIStatusChangeStore(gh<_i6.ChangeStatusAMSAPIEntity>()));
  gh.lazySingleton<_i10.GlobalInterPageConversationBloc>(
      () => _i10.GlobalInterPageConversationBloc());
  gh.factory<_i11.HomeNavigator>(
      () => _i11.HomeNavigator(appNavigator: gh<_i5.AppNavigator>()));
  gh.factory<_i12.HomePageAMSAPIFilterBloc>(
      () => _i12.HomePageAMSAPIFilterBloc());
  gh.factory<_i13.HomePageTabBloc>(() => _i13.HomePageTabBloc());
  await gh.lazySingletonAsync<_i14.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i15.ThemeRepository>(
      () => _i16.ThemeRepositoryImpl(gh<_i14.SharedPreferences>()));
  gh.factory<_i17.AMSAPIsNavigator>(
      () => _i17.AMSAPIsNavigator(gh<_i5.AppNavigator>()));
  gh.factory<_i18.CreateAMSAPIBloc>(
      () => _i18.CreateAMSAPIBloc(gh<_i7.CreateAMSAPIEntity>()));
  gh.factory<_i19.CreateAMSAPIPageModel>(() => _i19.CreateAMSAPIPageModel(
        gh<_i10.GlobalInterPageConversationBloc>(),
        gh<_i18.CreateAMSAPIBloc>(),
      ));
  gh.factory<_i20.CreateAMSAPIPagePresenter>(
      () => _i20.CreateAMSAPIPagePresenter(gh<_i19.CreateAMSAPIPageModel>()));
  gh.factory<_i21.FetchAMSAPIsBloc>(
      () => _i21.FetchAMSAPIsBloc(gh<_i8.GetAMSAPIEntities>()));
  gh.lazySingleton<_i22.LanguageRepository>(
      () => _i23.LanguageRepositoryImpl(gh<_i14.SharedPreferences>()));
  gh.factory<_i24.LoadSettings>(() => _i24.LoadSettings(
        gh<_i15.ThemeRepository>(),
        gh<_i22.LanguageRepository>(),
      ));
  gh.factory<_i25.SaveLanguage>(
      () => _i25.SaveLanguage(gh<_i22.LanguageRepository>()));
  gh.factory<_i26.SaveTheme>(() => _i26.SaveTheme(gh<_i15.ThemeRepository>()));
  await gh.lazySingletonAsync<_i27.GlobalSettingsStore>(
    () => _i27.GlobalSettingsStore.internalInit(
      gh<_i24.LoadSettings>(),
      gh<_i25.SaveLanguage>(),
      gh<_i26.SaveTheme>(),
    ),
    preResolve: true,
  );
  gh.factory<_i28.HomePageModel>(() => _i28.HomePageModel(
        gh<_i10.GlobalInterPageConversationBloc>(),
        gh<_i27.GlobalSettingsStore>(),
        gh<_i13.HomePageTabBloc>(),
        gh<_i21.FetchAMSAPIsBloc>(),
        gh<_i12.HomePageAMSAPIFilterBloc>(),
        gh<_i9.GlobalAMSAPIStatusChangeStore>(),
      ));
  gh.factory<_i29.HomePagePresenter>(
      () => _i29.HomePagePresenter(gh<_i28.HomePageModel>()));
  return getIt;
}

class _$InjectionModule extends _i30.InjectionModule {}
