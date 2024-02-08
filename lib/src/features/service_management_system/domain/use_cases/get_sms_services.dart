import 'package:ankabootmobile/src/core/domain/entities/failure.dart';
import 'package:ankabootmobile/src/core/utils/either/either.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/entities/sms_service_entity.dart';
import 'package:ankabootmobile/src/features/service_management_system/domain/repositories/sms_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSMSServices {
  final SMSRepository _smsRepository;

  const GetSMSServices(
    this._smsRepository,
  );

  Future<Either<Failure, List<SMSServiceEntity>>> call() =>
      _smsRepository.getServices();
}
