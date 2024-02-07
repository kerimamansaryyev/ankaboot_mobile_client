import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateAMSAPIEntity {
  final AMSAPIsRepository _apiRepository;

  const CreateAMSAPIEntity(
    this._apiRepository,
  );

  Future<Either<Failure, void>> call(
    CreateAMSAPIEntityDTO createAMSAPIEntityDTO,
  ) =>
      _apiRepository.createAPIEntity(createAMSAPIEntityDTO);
}
