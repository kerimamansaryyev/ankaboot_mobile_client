import 'package:ankabootmobile/src/core/utils/mvp/app_presenter.dart';
import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart';
import 'package:ankabootmobile/src/features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page_model.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page_view.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_theme.dart';
import 'package:ankabootmobile/src/features/settings/presentation/stores/global_settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class HomePagePresenter
    extends AppPresenter<HomePageView, HomePageModel> {
  @override
  @protected
  final HomePageModel model;

  HomePagePresenter(
    this.model,
  );

  factory HomePagePresenter.fromEnv() => serviceLocator<HomePagePresenter>();

  void toggleTheme(BuildContext context) =>
      switch (Theme.of(context).brightness) {
        Brightness.light => model.globalSettingsStore.setTheme(AppTheme.dark),
        Brightness.dark => model.globalSettingsStore.setTheme(AppTheme.light),
      };

  void setHomePageTabIndex(int index) => model.homePageTabBloc.setIndex(
        index,
      );

  void fetchAMSAPIs() => model.fetchAMSAPIsBloc.fetchApis(
        statusFilter: model.homePageAMSAPIFilterBloc.state.selectedStatus,
      );

  void setAMSAPIStatusFilter(AMSAPIStatus status) =>
      model.homePageAMSAPIFilterBloc.selectStatus(status);

  @override
  Widget buildMultiBlocListener(
    BuildContext context,
    Widget child, {
    Key? key,
  }) {
    return MultiBlocListener(
      listeners: [
        _onFiltersApplied(),
      ],
      child: child,
    );
  }

  BlocBase<GlobalSettingsState> globalSettingsStore() =>
      model.globalSettingsStore;

  BlocBase<int> homePageTabBloc() => model.homePageTabBloc;

  BlocBase<FetchAMSAPIsState> fetchAMSAPIsBloc() => model.fetchAMSAPIsBloc;

  BlocBase<HomePageAMSAPIFilterState> homePageAMSAPIFilterBloc() =>
      model.homePageAMSAPIFilterBloc;

  BlocListener _onFiltersApplied() =>
      BlocListener<HomePageAMSAPIFilterBloc, HomePageAMSAPIFilterState>(
        bloc: model.homePageAMSAPIFilterBloc,
        listener: (context, state) => model.fetchAMSAPIsBloc.fetchApis(
          statusFilter: state.selectedStatus,
        ),
      );
}
