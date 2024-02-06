import 'package:ankabootmobile/src/features/settings/presentation/stores/global_settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationEntry extends StatelessWidget {
  final WidgetBuilder builder;

  const LocalizationEntry({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalSettingsStore, GlobalSettingsState>(
      bloc: GlobalSettingsStore.fromEnv(),
      builder: (context, state) {
        return Localizations.override(
          context: context,
          locale: state.appLanguage.locale,
          child: Builder(
            builder: builder,
          ),
        );
      },
    );
  }
}
