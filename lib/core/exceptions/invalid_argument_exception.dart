/// {@template invalid_argument_exception}
/// An [Exception] that represents whether an invalid argument was provided.
/// {@endtemplate}
final class InvalidArgumentException implements Exception {
  /// {@macro invalid_argument_exception}
  const InvalidArgumentException(this.message);

  /// A message about this exception.
  final String message;
}
