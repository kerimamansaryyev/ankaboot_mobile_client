import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:ankabootmobile/src/core/ui/colors/context_color_extension.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/ui/widgets/empty_list_widget.dart';
import 'package:ankabootmobile/src/core/ui/widgets/error_list_widget.dart';
import 'package:ankabootmobile/src/core/ui/widgets/persisten_sliver_header.dart';
import 'package:ankabootmobile/src/core/utils/failure_mapper.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/stores/global_ams_api_status_change_store.dart';
import 'package:ankabootmobile/src/features/home/presentation/blocs/home_page_ams_api_filter_bloc.dart';
import 'package:ankabootmobile/src/features/home/presentation/home_navigator.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePageAMSAPIsTab extends StatefulWidget {
  final HomePagePresenter presenter;
  final HomeNavigator navigator;

  const HomePageAMSAPIsTab({
    required this.presenter,
    required this.navigator,
    super.key,
  });

  @override
  State<HomePageAMSAPIsTab> createState() => _HomePageAMSAPIsTabState();
}

class _HomePageAMSAPIsTabState extends State<HomePageAMSAPIsTab>
    with AutomaticKeepAliveClientMixin {
  static const _cardBorderRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BlocBase<FetchAMSAPIsState>, FetchAMSAPIsState>(
      bloc: widget.presenter.fetchAMSAPIsBloc(),
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async {
          widget.presenter.fetchAMSAPIs();
        },
        child: Scaffold(
          backgroundColor: context.colors.homePageScaffoldColor,
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      floating: true,
                      delegate: PersistentSliverHeader(
                        child: _AMSFilterStatusCarousel(
                          homePagePresenter: widget.presenter,
                        ),
                        height: _AMSFilterStatusCarousel._height,
                      ),
                    ),
                    switch (state) {
                      FetchAMSAPIsLoading() => const SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      FetchAMSAPIsEmpty() => SliverFillRemaining(
                          child: EmptyListWidget(
                            text: context.translation.homePagesEmptyAPIs,
                          ),
                        ),
                      FetchAMSAPIsError(failure: final failure) =>
                        SliverFillRemaining(
                          child: ErrorListWidget(
                            refreshCallback: () =>
                                widget.presenter.fetchAMSAPIs(),
                            text: failure.mapToStringWith(context),
                          ),
                        ),
                      FetchAMSAPIsSucceeded(apiEntities: final apiEntities) =>
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.gap,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Container(
                                margin: EdgeInsets.only(
                                  bottom: 0.3.gap,
                                ),
                                child: BlocBuilder<
                                    BlocBase<GlobalAMSAPIStatusChangeState>,
                                    GlobalAMSAPIStatusChangeState>(
                                  bloc: widget.presenter
                                      .globalAMSAPIStatusChangeStore(),
                                  builder: (context, state) {
                                    final transformedEntity = apiEntities[index]
                                        .transformWithRecordedStatus(state);
                                    final isLoading = state
                                            .items[transformedEntity.id]
                                        is GlobalAMSAPIStatusChangeStateItemLoading;

                                    return AbsorbPointer(
                                      absorbing: isLoading,
                                      child: AnimatedOpacity(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        opacity: isLoading ? 0.5 : 1,
                                        child: Slidable(
                                          key: ValueKey(index),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              0.5.wBox,
                                              SlidableAction(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  _cardBorderRadius,
                                                ),
                                                onPressed: (context) => widget
                                                    .navigator
                                                    .showChooseAMSStatusDialog(
                                                  context,
                                                  selectedStatus:
                                                      transformedEntity.status,
                                                  onStatusChosen: (status) =>
                                                      widget.presenter
                                                          .updateAMSAPIStatus(
                                                    amsAPIId:
                                                        transformedEntity.id,
                                                    currentStatus:
                                                        transformedEntity
                                                            .status,
                                                    newStatus: status,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondaryContainer,
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                icon: Icons.settings,
                                                label: context.translation
                                                    .homePageAPIStatus,
                                              ),
                                            ],
                                          ),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                _cardBorderRadius,
                                              ),
                                            ),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiaryContainer,
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
                                                              transformedEntity
                                                                  .title,
                                                              style: Theme.of(
                                                                context,
                                                              )
                                                                  .textTheme
                                                                  .titleMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.drag_handle,
                                                          ),
                                                        ],
                                                      ),
                                                      0.5.hBox,
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              transformedEntity
                                                                  .description,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      0.5.hBox,
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'URL: ${transformedEntity.url}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                            _cardBorderRadius,
                                                          ),
                                                          bottomRight:
                                                              Radius.circular(
                                                            _cardBorderRadius,
                                                          ),
                                                        ),
                                                        color: transformedEntity
                                                            .status
                                                            .color()
                                                            .withOpacity(0.85),
                                                      ),
                                                      width: 125,
                                                      height: 30,
                                                      child: Center(
                                                        child: Text(
                                                          transformedEntity
                                                              .status.name
                                                              .toUpperCase(),
                                                          textScaler: TextScaler
                                                              .noScaling,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              childCount: apiEntities.length,
                            ),
                          ),
                        ),
                    },
                  ],
                ),
              ),
              Container(
                color: context.colors.homePageScaffoldColor,
                padding: EdgeInsets.symmetric(
                  vertical: 0.1.gap,
                  horizontal: 0.2.gap,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                        onPressed: () =>
                            widget.navigator.navigateToCreateAMSAPIPage(
                          context,
                        ),
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        label: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.75.gap,
                          ),
                          child: Text(
                            context.translation.homePageAddAPI,
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AMSFilterStatusCarousel extends StatelessWidget {
  static const _height = 65.0;

  final HomePagePresenter homePagePresenter;

  const _AMSFilterStatusCarousel({
    required this.homePagePresenter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.homePageScaffoldColor,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: _height,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 1.25.gap,
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  for (final status in AMSAPIStatus.displayValues)
                    BlocBuilder<BlocBase<HomePageAMSAPIFilterState>,
                        HomePageAMSAPIFilterState>(
                      bloc: homePagePresenter.homePageAMSAPIFilterBloc(),
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: 0.75.gap,
                          ),
                          child: FilterChip(
                            label: Text(
                              status.name.toUpperCase(),
                            ),
                            selected: state.selectedStatus == status,
                            showCheckmark: false,
                            onSelected: (bool _) =>
                                homePagePresenter.setAMSAPIStatusFilter(
                              status,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
