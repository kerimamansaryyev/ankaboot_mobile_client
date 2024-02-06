import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';

abstract interface class AMSAPIsRepository {
  Future<Either<Failure, List<AMSAPIEntity>>> getAMSAPIEntities({
    required AMSAPIStatus? statusFilter,
  });
}
