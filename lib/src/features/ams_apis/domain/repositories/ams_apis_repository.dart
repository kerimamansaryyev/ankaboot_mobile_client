import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';

typedef CreateAMSAPIEntityDTO = ({
  AMSAPIStatus status,
  String url,
  String description,
  String title,
});

typedef ChangeStatusAMSAPIEntityDTO = ({
  String apiID,
  AMSAPIStatus newStatus,
});

abstract interface class AMSAPIsRepository {
  Future<Either<Failure, List<AMSAPIEntity>>> getAMSAPIEntities({
    required AMSAPIStatus? statusFilter,
  });
  Future<Either<Failure, void>> changeStatusOfAPI(
    ChangeStatusAMSAPIEntityDTO changeStatusAMSAPIEntityDTO,
  );
  Future<Either<Failure, void>> createAPIEntity(
    CreateAMSAPIEntityDTO createAMSAPIEntityDTO,
  );
}
