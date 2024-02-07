import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/di/annotations.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:injectable/injectable.dart';

const _mockAPIEntities = [
  AMSAPIEntity(
    id: '1',
    status: AMSAPIStatus.free,
    title: 'Title 1',
    url: 'http://moon.com',
    description: 'This is very good API Lorem Ipsum',
  ),
  AMSAPIEntity(
    id: '2',
    status: AMSAPIStatus.newAPI,
    title: 'Title 2',
    url: 'http://earth.com',
    description: 'This is very good API Lorem Ipsum',
  ),
  AMSAPIEntity(
    id: '3',
    status: AMSAPIStatus.unavailable,
    title: 'Title 3',
    url: 'http://google.com',
    description: 'This is very good API',
  ),
  AMSAPIEntity(
    id: '4',
    status: AMSAPIStatus.uncertain,
    title: 'Title 4',
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
        // () => Left(
        //   UnknownFailure(
        //     exception: Exception('generic exception'),
        //   ),
        // ),
        () => Right(
          [..._mockAPIEntities, ..._mockAPIEntities]
              .where(
                (element) =>
                    statusFilter == null || element.status == statusFilter,
              )
              .toList(),
        ),
      );

  @override
  Future<Either<Failure, void>> changeStatusOfAPI({
    required String apiID,
    required AMSAPIStatus newStatus,
  }) =>
      Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => const Right(null),
        // () => const Left(
        //   UnknownFailure(),
        // ),
      );
}
