import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationTranslationExtension on BuildContext {
  AppLocalizations get translation {
    final trnsl = AppLanguage.translation(this);
    assert(trnsl != null);
    return trnsl!;
  }

  MaterialLocalizations get materialTranslation =>
      MaterialLocalizations.of(this);
}
