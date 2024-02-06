import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';

final class AMSAPIEntity {
  final AMSAPIStatus status;
  final String url;
  final String description;

  const AMSAPIEntity({
    required this.status,
    required this.url,
    required this.description,
  });
}
