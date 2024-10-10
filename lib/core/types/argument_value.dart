import 'dart:io';

import 'package:dcat/core/exceptions/missing_file_exception.dart';

/// Sealed class for all types of parameters accepted
sealed class DcatArgumentValue {
  const DcatArgumentValue();
}

/// Class that represents an existent file.
///
/// If file not exists, throws [MissingFileException].
final class RegularFileArgument extends DcatArgumentValue {
  RegularFileArgument(this._file) {
    if (!_file.existsSync()) {
      throw MissingFileException('Inexistent file: ${_file.path}');
    }
  }
  final File _file;

  File get file => _file;
}

/// Represents an input for reading the standard input.
///
/// If not empty string a single dash, throws [FormatException].
final class StandardInputArgument extends DcatArgumentValue {
  StandardInputArgument(String input)
      : _input = input == '' || input == '-'
            ? input
            : throw FormatException(
                'Should be an empty string or dash',
                input,
              );
  final String _input;

  String get input => _input;
}
