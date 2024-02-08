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
import 'package:shared_preferences/shared_preferences.dart' as _i16;

import '../core/di/injection_module.dart' as _i34;
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
import '../features/ams_apis/presentation/ams_apis_navigator.dart' as _i19;
import '../features/ams_apis/presentation/blocs/create_ams_api_bloc.dart'
    as _i20;
import '../features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart'
    as _i23;
import '../features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_model.dart'
    as _i21;
import '../features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_presenter.dart'
    as _i22;
import '../features/ams_apis/presentation/stores/global_ams_api_status_change_store.dart'
    as _i9;
import '../features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart'
    as _i12;
import '../features/home/presentation/blocs/home_page_tab_bloc.dart' as _i13;
import '../features/home/presentation/home_navigator.dart' as _i11;
import '../features/home/presentation/pages/home_page/home_page_model.dart'
    as _i32;
import '../features/home/presentation/pages/home_page/home_page_presenter.dart'
    as _i33;
import '../features/service_management_system/data/repository_impls/mock_sms_repository_impl.dart'
    as _i15;
import '../features/service_management_system/domain/repositories/sms_repository.dart'
    as _i14;
import '../features/service_management_system/domain/use_cases/get_sms_services.dart'
    as _i24;
import '../features/service_management_system/presentation/blocs/fetch_sms_services.dart'
    as _i30;
import '../features/settings/data/repository_impls/language_repository_impl.dart'
    as _i26;
import '../features/settings/data/repository_impls/theme_repository_impl.dart'
    as _i18;
import '../features/settings/domain/repositories/language_repository.dart'
    as _i25;
import '../features/settings/domain/repositories/theme_repository.dart' as _i17;
import '../features/settings/domain/use_cases/load_settings.dart' as _i27;
import '../features/settings/domain/use_cases/save_language.dart' as _i28;
import '../features/settings/domain/use_cases/save_theme.dart' as _i29;
import '../features/settings/presentation/stores/global_settings_store.dart'
    as _i31;

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
  gh.lazySingleton<_i14.SMSRepository>(
    () => _i15.MockSMSRepositoryImpl(),
    registerFor: {_test},
  );
  await gh.lazySingletonAsync<_i16.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i17.ThemeRepository>(
      () => _i18.ThemeRepositoryImpl(gh<_i16.SharedPreferences>()));
  gh.factory<_i19.AMSAPIsNavigator>(
      () => _i19.AMSAPIsNavigator(gh<_i5.AppNavigator>()));
  gh.factory<_i20.CreateAMSAPIBloc>(
      () => _i20.CreateAMSAPIBloc(gh<_i7.CreateAMSAPIEntity>()));
  gh.factory<_i21.CreateAMSAPIPageModel>(() => _i21.CreateAMSAPIPageModel(
        gh<_i10.GlobalInterPageConversationBloc>(),
        gh<_i20.CreateAMSAPIBloc>(),
      ));
  gh.factory<_i22.CreateAMSAPIPagePresenter>(
      () => _i22.CreateAMSAPIPagePresenter(gh<_i21.CreateAMSAPIPageModel>()));
  gh.factory<_i23.FetchAMSAPIsBloc>(
      () => _i23.FetchAMSAPIsBloc(gh<_i8.GetAMSAPIEntities>()));
  gh.factory<_i24.GetSMSServices>(
      () => _i24.GetSMSServices(gh<_i14.SMSRepository>()));
  gh.lazySingleton<_i25.LanguageRepository>(
      () => _i26.LanguageRepositoryImpl(gh<_i16.SharedPreferences>()));
  gh.factory<_i27.LoadSettings>(() => _i27.LoadSettings(
        gh<_i17.ThemeRepository>(),
        gh<_i25.LanguageRepository>(),
      ));
  gh.factory<_i28.SaveLanguage>(
      () => _i28.SaveLanguage(gh<_i25.LanguageRepository>()));
  gh.factory<_i29.SaveTheme>(() => _i29.SaveTheme(gh<_i17.ThemeRepository>()));
  gh.factory<_i30.FetchSMSServicesBloc>(
      () => _i30.FetchSMSServicesBloc(gh<_i24.GetSMSServices>()));
  await gh.lazySingletonAsync<_i31.GlobalSettingsStore>(
    () => _i31.GlobalSettingsStore.internalInit(
      gh<_i27.LoadSettings>(),
      gh<_i28.SaveLanguage>(),
      gh<_i29.SaveTheme>(),
    ),
    preResolve: true,
  );
  gh.factory<_i32.HomePageModel>(() => _i32.HomePageModel(
        gh<_i30.FetchSMSServicesBloc>(),
        gh<_i10.GlobalInterPageConversationBloc>(),
        gh<_i31.GlobalSettingsStore>(),
        gh<_i13.HomePageTabBloc>(),
        gh<_i23.FetchAMSAPIsBloc>(),
        gh<_i12.HomePageAMSAPIFilterBloc>(),
        gh<_i9.GlobalAMSAPIStatusChangeStore>(),
      ));
  gh.factory<_i33.HomePagePresenter>(
      () => _i33.HomePagePresenter(gh<_i32.HomePageModel>()));
  return getIt;
}

class _$InjectionModule extends _i34.InjectionModule {}
