import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/ui/widgets/empty_list_widget.dart';
import 'package:ankabootmobile/src/core/ui/widgets/error_list_widget.dart';
import 'package:ankabootmobile/src/core/utils/failure_mapper.dart';
import 'package:ankabootmobile/src/features/home/presentation/home_navigator.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page_presenter.dart';
import 'package:ankabootmobile/src/features/service_management_system/presentation/blocs/fetch_sms_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageSMSServicesTab extends StatefulWidget {
  final HomePagePresenter presenter;
  final HomeNavigator navigator;

  const HomePageSMSServicesTab({
    required this.presenter,
    required this.navigator,
    super.key,
  });

  @override
  State<HomePageSMSServicesTab> createState() => _HomePageSMSServicesTabState();
}

class _HomePageSMSServicesTabState extends State<HomePageSMSServicesTab> {
  static const _cardBorderRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBase<FetchSMSServicesState>, FetchSMSServicesState>(
      bloc: widget.presenter.fetchSMSServicesBloc(),
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async => widget.presenter.fetchSMSServices(),
        child: CustomScrollView(
          slivers: [
            switch (state) {
              FetchSMSServicesLoading() => const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              FetchSMSServicesEmpty() => SliverFillRemaining(
                  child: EmptyListWidget(
                    text: context.translation.homePageEmptyServices,
                  ),
                ),
              FetchSMSServicesError(failure: final failure) =>
                SliverFillRemaining(
                  child: ErrorListWidget(
                    refreshCallback: () => widget.presenter.fetchSMSServices(),
                    text: failure.mapToStringWith(context),
                  ),
                ),
              FetchSMSServicesSucceeded(
                serviceEntities: final serviceEntities
              ) =>
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.gap,
                  ),
                  sliver: SliverList.builder(
                    itemCount: serviceEntities.length,
                    itemBuilder: (context, index) => Card(
                      margin: EdgeInsets.only(
                        bottom: 0.8.gap,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          _cardBorderRadius,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                              1.gap,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${context.translation.homePageServiceService}: ${serviceEntities[index].id}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                0.75.hBox,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${context.translation.homePageServiceContainer}: ${serviceEntities[index].containerName}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                0.25.hBox,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${context.translation.homePageServiceImage}: ${serviceEntities[index].containerImage}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            },
          ],
        ),
      ),
    );
  }
}
