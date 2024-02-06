import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/di/annotations.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:injectable/injectable.dart';

const _mockAPIEntities = [
  AMSAPIEntity(
    status: AMSAPIStatus.free,
    url: 'http://moon.com',
    description: 'This is very good API Lorem Ipsum',
  ),
  AMSAPIEntity(
    status: AMSAPIStatus.newAPI,
    url: 'http://earth.com',
    description: 'This is very good API Lorem Ipsum',
  ),
  AMSAPIEntity(
    status: AMSAPIStatus.unavailable,
    url: 'http://google.com',
    description: 'This is very good API',
  ),
  AMSAPIEntity(
    status: AMSAPIStatus.uncertain,
    url: 'http://google.com',
    description: 'This is very good API',
  ),
];

@testEnv
@LazySingleton(as: AMSAPIsRepository)
final class MockAMSAPIsRepository implements AMSAPIsRepository {
  @override
  Future<Either<Failure, List<AMSAPIEntity>>> getAMSAPIEntities({
    required AMSAPIStatus? statusFilter,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => Right(
          [..._mockAPIEntities, ..._mockAPIEntities]
              .where(
                (element) =>
                    statusFilter == null || element.status == statusFilter,
              )
              .toList(),
        ),
      );
}
