import 'package:ankabootmobile/src/core/navigation/app_navigator.dart';
import 'package:ankabootmobile/src/features/home/presentation/pages/home_page/home_page.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_theme.dart';
import 'package:ankabootmobile/src/features/settings/presentation/stores/global_settings_store.dart';
import 'package:ankabootmobile/src/features/settings/presentation/widgets/localization_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptix/adaptix.dart';

class AnkabootApp extends StatefulWidget {
  const AnkabootApp({super.key});

  @override
  State<AnkabootApp> createState() => _AnkabootAppState();
}

class _AnkabootAppState extends State<AnkabootApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      navigatorKey: AppNavigator.navigatorKey,
      localizationsDelegates: AppLanguage.delegates,
      supportedLocales: AppLanguage.supportedLocales,
      builder: (context, child) {
        return LocalizationEntry(
          builder: (context) => AdaptixInitializer(
            configs: const AdaptixConfigs.canonical(),
            builder: (context) {
              return BlocBuilder<GlobalSettingsStore, GlobalSettingsState>(
                bloc: GlobalSettingsStore.fromEnv(),
                builder: (context, settingsStoreState) {
                  return Theme(
                    data: settingsStoreState.appTheme?.themeData ??
                        AppTheme.fromBrightness(
                          MediaQuery.of(context).platformBrightness,
                        ).themeData,
                    child: child!,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
