import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeStatusAMSAPIEntity {
  final AMSAPIsRepository _amsRepository;

  const ChangeStatusAMSAPIEntity(
    this._amsRepository,
  );

  Future<Either<Failure, void>> call(
    ChangeStatusAMSAPIEntityDTO changeStatusAMSAPIEntity,
  ) =>
      _amsRepository.changeStatusOfAPI(changeStatusAMSAPIEntity);
}
