import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/di/annotations.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_entity.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/repositories/ams_apis_repository.dart';
import 'package:injectable/injectable.dart';

final _mockAPIEntities = <String, AMSAPIEntity>{
  for (int i = 0; i < 10; i++)
    i.toString(): AMSAPIEntity(
      id: i.toString(),
      title: 'Title $i',
      status: AMSAPIStatus.values[i % AMSAPIStatus.values.length],
      url: 'https://api$i.hello.com',
      description: 'Very useful API for getting subscribers count',
    ),
};
int _lastApiIndex = _mockAPIEntities.length;

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
          [..._mockAPIEntities.values]
              .where(
                (element) =>
                    statusFilter == null || element.status == statusFilter,
              )
              .toList(),
        ),
      );

  @override
  Future<Either<Failure, void>> changeStatusOfAPI(
    ChangeStatusAMSAPIEntityDTO changeStatusAMSAPIEntityDTO,
  ) =>
      Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () {
          if (!_mockAPIEntities
              .containsKey(changeStatusAMSAPIEntityDTO.apiID)) {
            return Left(
              UnknownFailure(
                exception: Exception('Did not find the api entity'),
              ),
            );
          }
          final apiEntity =
              _mockAPIEntities[changeStatusAMSAPIEntityDTO.apiID]!;
          _mockAPIEntities[changeStatusAMSAPIEntityDTO.apiID] = AMSAPIEntity(
            id: apiEntity.id,
            title: apiEntity.title,
            status: changeStatusAMSAPIEntityDTO.newStatus,
            url: apiEntity.url,
            description: apiEntity.description,
          );
          return const Right(null);
        },
        // () => const Left(
        //   UnknownFailure(),
        // ),
      );

  @override
  Future<Either<Failure, void>> createAPIEntity(
    CreateAMSAPIEntityDTO createAMSAPIEntityDTO,
  ) async {
    final id = _lastApiIndex++;
    _mockAPIEntities[id.toString()] = AMSAPIEntity(
      id: id.toString(),
      title: createAMSAPIEntityDTO.title,
      status: createAMSAPIEntityDTO.status,
      url: createAMSAPIEntityDTO.url,
      description: createAMSAPIEntityDTO.description,
    );
    await Future.delayed(const Duration(seconds: 2));
    return const Right(null);
  }
}
