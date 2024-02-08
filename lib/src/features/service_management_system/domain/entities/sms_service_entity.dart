final class SMSServiceEntity {
  final String id;
  final String containerImage;
  final String containerName;
  final String port;

  SMSServiceEntity({
    required this.id,
    required this.containerImage,
    required this.containerName,
    required this.port,
  });
}
