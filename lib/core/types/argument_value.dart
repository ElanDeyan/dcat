import 'dart:io';

import 'package:dcat/core/exceptions/missing_file_exception.dart';

/// Sealed class for all types of parameters accepted
sealed class DcatArgumentValue {
  const DcatArgumentValue();
}

/// {@template regular_file_argument}
/// Class that represents an existent file.
///
/// If file not exists, throws [MissingFileException].
/// {@endtemplate}
final class RegularFileArgument extends DcatArgumentValue {
  /// {@macro regular_file_argument}
  RegularFileArgument(this._file) {
    if (!_file.existsSync()) {
      throw MissingFileException('Inexistent file: ${_file.path}');
    }
  }
  final File _file;

  /// The [File] passed as argument.
  File get file => _file;
}

/// {@template standard_input_argument}
/// Represents an input for reading the standard input.
///
/// If not empty string a single dash, throws [FormatException].
/// {@endtemplate}
final class StandardInputArgument extends DcatArgumentValue {
  /// {@macro standard_input_argument}
  const StandardInputArgument();
}
