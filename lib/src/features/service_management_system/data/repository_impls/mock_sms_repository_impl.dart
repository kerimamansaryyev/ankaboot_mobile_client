import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/di/annotations.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/entities/sms_service_entity.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/repositories/sms_repository.dart';
import 'package:injectable/injectable.dart';

final _mockEntities = <String, SMSServiceEntity>{
  for (int i = 0; i < 10; i++)
    i.toString(): SMSServiceEntity(
      id: i.toString(),
      containerImage: 'image $i',
      containerName: 'container $i',
      port: (i + 8080).toString(),
    ),
};

@testEnv
@LazySingleton(
  as: SMSRepository,
)
final class MockSMSRepositoryImpl implements SMSRepository {
  @override
  Future<Either<Failure, List<SMSServiceEntity>>> getServices() =>
      Future.delayed(
        const Duration(seconds: 2),
        () => Right(_mockEntities.values.toList()),
        // () => Right([]),
        // () => Left(const UnknownFailure()),
      );
}
