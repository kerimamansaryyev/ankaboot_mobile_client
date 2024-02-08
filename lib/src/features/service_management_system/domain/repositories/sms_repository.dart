import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/entities/sms_service_entity.dart';

abstract interface class SMSRepository {
  Future<Either<Failure, List<SMSServiceEntity>>> getServices();
}
