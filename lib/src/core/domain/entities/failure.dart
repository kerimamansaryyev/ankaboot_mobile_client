abstract interface class Failure {
  abstract final Exception? exception;
  abstract final StackTrace? stackTrace;
}

final class ShallowException implements Exception {
  final dynamic object;

  const ShallowException(this.object);

  @override
  String toString() {
    return 'ShallowException(object=${object.toString()})';
  }
}

final class UnknownFailure implements Failure {
  @override
  final Exception? exception;

  @override
  final StackTrace? stackTrace;

  const UnknownFailure({
    this.exception,
    this.stackTrace,
  });
}
