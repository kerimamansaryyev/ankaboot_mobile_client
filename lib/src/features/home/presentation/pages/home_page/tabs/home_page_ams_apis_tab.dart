import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:ankabootmobile/src/core/ui/colors/context_color_extension.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/ui/widgets/persisten_sliver_header.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/fetch_ams_apis_bloc.dart';
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
      builder: (context, state) => CustomScrollView(
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
            FetchAMSAPIsEmpty() => const SliverToBoxAdapter(),
            FetchAMSAPIsError() => const SliverToBoxAdapter(),
            FetchAMSAPIsSucceeded(apiEntities: final apiEntities) =>
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: 1.gap,
                  vertical: 0.5.gap,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      margin: EdgeInsets.only(
                        bottom: 0.5.gap,
                      ),
                      child: Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            0.5.wBox,
                            SlidableAction(
                              borderRadius: BorderRadius.circular(
                                _cardBorderRadius,
                              ),
                              onPressed: (context) =>
                                  widget.navigator.showChooseAMSStatusDialog(
                                context,
                                selectedStatus: apiEntities[index].status,
                                onStatusChosen: (_) {},
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              icon: Icons.settings,
                              label: context.translation.homePageAPIStatus,
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              _cardBorderRadius,
                            ),
                          ),
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
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
                                            apiEntities[index].url,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
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
                                            apiEntities[index].description,
                                          ),
                                        )
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
                                      borderRadius: const BorderRadius.only(
                                        topLeft:
                                            Radius.circular(_cardBorderRadius),
                                        bottomRight:
                                            Radius.circular(_cardBorderRadius),
                                      ),
                                      color: apiEntities[index].status.color(),
                                    ),
                                    width: 125,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        apiEntities[index]
                                            .status
                                            .name
                                            .toUpperCase(),
                                        textScaler: TextScaler.noScaling,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    childCount: apiEntities.length,
                  ),
                ),
              ),
          },
        ],
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
    super.key,
  });

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
                  horizontal: 1.gap,
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  for (final status in AMSAPIStatus.values)
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
          )
        ],
      ),
    );
  }
}
