import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:ankabootmobile/src/core/ui/colors/context_color_extension.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/utils/constants.dart';
import 'package:ankabootmobile/src/features/home/presentation/home_navigator.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page_presenter.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page_view.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/tabs/home_page_ams_apis_tab.dart';
import 'package:ankabootmobile/src/features/settings/presentation/stores/global_settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomePageView {
  late final _presenter = HomePagePresenter.fromEnv()
    ..bindView(this)
    ..fetchAMSAPIs();
  late final _navigator = HomeNavigator.fromEnv();
  late final _tabBarController = PageController();

  void _goToPage(int index) => _tabBarController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _presenter.buildMultiBlocListener(
      context,
      Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: false,
          actions: [
            BlocBuilder<BlocBase<GlobalSettingsState>, GlobalSettingsState>(
              bloc: _presenter.globalSettingsStore(),
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: 1.gap,
                  ),
                  child: IconButton(
                    onPressed: () => _presenter.toggleTheme(context),
                    icon: Icon(
                      switch (Theme.of(context).brightness) {
                        Brightness.light => Icons.light_mode,
                        Brightness.dark => Icons.dark_mode,
                      },
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              },
            ),
          ],
          title: Text(
            AppConstants.appName,
            textScaler: TextScaler.noScaling,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        backgroundColor: context.colors.homePageScaffoldColor,
        body: SafeArea(
          top: false,
          child: PageView(
            controller: _tabBarController,
            onPageChanged: _presenter.setHomePageTabIndex,
            children: [
              HomePageAMSAPIsTab(
                presenter: _presenter,
                navigator: _navigator,
              ),
              const SizedBox(),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<BlocBase<int>, int>(
          bloc: _presenter.homePageTabBloc(),
          builder: (context, tabIndex) {
            return NavigationBar(
              selectedIndex: tabIndex,
              onDestinationSelected: _goToPage,
              destinations: [
                NavigationDestination(
                  icon: const Icon(
                    Icons.article_rounded,
                  ),
                  label: context.translation.homePageAPIsTab,
                ),
                NavigationDestination(
                  icon: const Icon(
                    Icons.wifi_tethering_rounded,
                  ),
                  label: context.translation.homePageServicesTab,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
