import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/settings/domain/entities/app_language.dart';
import 'package:ankabootmobile/src/features/settings/domain/repositories/language_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveLanguage {
  final LanguageRepository _languageRepository;

  const SaveLanguage(
    this._languageRepository,
  );

  Future<Either<Failure, void>> call(AppLanguage language) =>
      _languageRepository.saveLanguage(language);
}
