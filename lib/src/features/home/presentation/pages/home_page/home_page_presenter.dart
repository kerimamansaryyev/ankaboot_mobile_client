import 'package:ankabootmobile/src/core/utils/failure_mapper.dart';
import 'package:ankabootmobile/src/core/utils/mvp/app_presenter.dart';
import 'package:ankabootmobile/src/di/injection_container.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/stores/global_ams_api_status_change_store.dart';
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

  void updateAMSAPIStatus({
    required String amsAPIId,
    required AMSAPIStatus currentStatus,
    required AMSAPIStatus newStatus,
  }) =>
      model.globalAMSAPIStatusChangeStore.changeStatus(
        apiEntity: (
          id: amsAPIId,
          status: currentStatus,
        ),
        newStatus: newStatus,
      );

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
        _onAPIsFetched(),
        _onAPIStatusChangeAttempted(),
      ],
      child: child,
    );
  }

  BlocBase<GlobalAMSAPIStatusChangeState> globalAMSAPIStatusChangeStore() =>
      model.globalAMSAPIStatusChangeStore;

  BlocBase<GlobalSettingsState> globalSettingsStore() =>
      model.globalSettingsStore;

  BlocBase<int> homePageTabBloc() => model.homePageTabBloc;

  BlocBase<FetchAMSAPIsState> fetchAMSAPIsBloc() => model.fetchAMSAPIsBloc;

  BlocBase<HomePageAMSAPIFilterState> homePageAMSAPIFilterBloc() =>
      model.homePageAMSAPIFilterBloc;

  BlocListener _onAPIStatusChangeAttempted() => BlocListener<
          GlobalAMSAPIStatusChangeStore, GlobalAMSAPIStatusChangeState>(
        bloc: model.globalAMSAPIStatusChangeStore,
        listener: (context, state) => switch (state.latest) {
          GlobalAMSAPIStatusChangeStateItemSucceeded() ||
          GlobalAMSAPIStatusChangeStateItemLoading() ||
          null =>
            null,
          GlobalAMSAPIStatusChangeStateItemError(failure: final failure) =>
            view?.showErrorDialog(
              context,
              failure.mapToStringWith(context),
            ),
        },
      );

  BlocListener _onAPIsFetched() =>
      BlocListener<FetchAMSAPIsBloc, FetchAMSAPIsState>(
        bloc: model.fetchAMSAPIsBloc,
        listener: (context, state) {
          switch (state) {
            case FetchAMSAPIsLoading():
              return;
            case FetchAMSAPIsEmpty():
              return;
            case FetchAMSAPIsError():
              return;
            case FetchAMSAPIsSucceeded(apiEntities: final apiEntities):
              model.globalAMSAPIStatusChangeStore.clearSucceededOnesWith(
                snippets: apiEntities
                    .map((e) => (id: e.id, status: e.status))
                    .toList(),
              );
          }
        },
      );

  BlocListener _onFiltersApplied() =>
      BlocListener<HomePageAMSAPIFilterBloc, HomePageAMSAPIFilterState>(
        bloc: model.homePageAMSAPIFilterBloc,
        listener: (context, state) => model.fetchAMSAPIsBloc.fetchApis(
          statusFilter: state.selectedStatus,
        ),
      );
}
