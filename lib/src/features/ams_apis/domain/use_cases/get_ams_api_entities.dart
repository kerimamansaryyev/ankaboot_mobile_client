import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAMSAPIEntities {
  final AMSAPIsRepository _amsRepository;

  const GetAMSAPIEntities(
    this._amsRepository,
  );

  Future<Either<Failure, List<AMSAPIEntity>>> call({
    AMSAPIStatus? statusFilter,
  }) =>
      _amsRepository.getAMSAPIEntities(
        statusFilter: statusFilter,
      );
}
