import 'dart:io';

/// {@template missing_file_exception}
/// An [Exception] that represents whether a [File] not exists.
/// {@endtemplate}
final class MissingFileException implements Exception {
  /// {@macro missing_file_exception}
  const MissingFileException(this.message);

  /// A message about this [Exception].
  final String message;
}
