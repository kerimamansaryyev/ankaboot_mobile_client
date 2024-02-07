import 'package:ankabootmobile/src/core/utils/mvp/app_model.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/stores/global_ams_api_status_change_store.dart';
import 'package:ankabootmobile/src/features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart';
import 'package:ankabootmobile/src/features/home/presentation/blocs/home_page_tab_bloc.dart';
import 'package:ankabootmobile/src/features/settings/presentation/stores/global_settings_store.dart';
import 'package:injectable/injectable.dart';

@injectable
final class HomePageModel implements AppModel {
  final GlobalSettingsStore globalSettingsStore;
  final HomePageTabBloc homePageTabBloc;
  final FetchAMSAPIsBloc fetchAMSAPIsBloc;
  final HomePageAMSAPIFilterBloc homePageAMSAPIFilterBloc;
  final GlobalAMSAPIStatusChangeStore globalAMSAPIStatusChangeStore;

  const HomePageModel(
    this.globalSettingsStore,
    this.homePageTabBloc,
    this.fetchAMSAPIsBloc,
    this.homePageAMSAPIFilterBloc,
    this.globalAMSAPIStatusChangeStore,
  );
}
