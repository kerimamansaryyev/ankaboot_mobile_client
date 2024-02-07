import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';

final class AMSAPIEntity {
  final String id;
  final AMSAPIStatus status;
  final String url;
  final String description;
  final String title;

  const AMSAPIEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.url,
    required this.description,
  });
}
