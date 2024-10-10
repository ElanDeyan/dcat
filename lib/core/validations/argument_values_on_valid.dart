import 'dart:io';
import 'package:dcat/core/exceptions/invalid_argument_exception.dart';
import 'package:dcat/core/exceptions/missing_file_exception.dart';
import 'package:dcat/core/types/argument_value.dart';

/// Validates [arguments], returning a [List] of [DcatArgumentValue] if valid,
/// or throws [InvalidArgumentException] if some error occurs.
List<DcatArgumentValue> argumentValuesOnValid(List<String> arguments) {
  try {
    final argumentValues = <DcatArgumentValue>[];
    for (final argument in arguments) {
      try {
        switch (argument) {
          case '' || '-':
            argumentValues.add(StandardInputArgument(argument));
          default:
            argumentValues.add(RegularFileArgument(File(argument)));
        }
      } on MissingFileException catch (e) {
        stdout.writeln(e.message);
        rethrow;
      } on FormatException catch (e) {
        stdout.writeln(e.message);
        rethrow;
      }
    }

    return argumentValues;
  } on Exception catch (e) {
    throw InvalidArgumentException(e.toString());
  }
}
