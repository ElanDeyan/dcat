import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dcat/core/exceptions/invalid_argument_exception.dart';
import 'package:dcat/core/types/argument_value.dart';
import 'package:dcat/core/validations/argument_values_on_valid.dart';
import 'package:quiver/strings.dart';

Future<void> displayFilesContent(
  List<String> arguments, {
  bool displayLinesNumber = false,
  bool skipBlankLines = false,
}) async {
  late final List<DcatArgumentValue> values;
  try {
    values = await Isolate.run(() => argumentValuesOnValid(arguments));
  } on InvalidArgumentException catch (e) {
    stdout
      ..writeln('oops!')
      ..writeln(e.message);
    return;
  }

  if (values.isNotEmpty) {
    await Isolate.run(
      () => _onData(
        values,
        displayLinesNumber: displayLinesNumber,
        skipBlankLines: skipBlankLines,
      ),
    );
  } else {
    stdout.writeln('No content provided!');
  }
}

Future<void> _onData(
  List<DcatArgumentValue> values, {
  bool displayLinesNumber = false,
  bool skipBlankLines = false,
}) async {
  for (final argument in values) {
    stdout.writeln();

    late final List<String> lines;
    const lineSplitter = LineSplitter();
    switch (argument) {
      case RegularFileArgument(:final file):
        stdout.writeln('${'-' * 5} ${file.path} ${'-' * 5}');
        lines = lineSplitter.convert(await file.readAsString());
      case StandardInputArgument():
        stdout.writeln('${'-' * 5} Standard input ${'-' * 5}');
        lines = lineSplitter.convert(stdin.readLineSync() ?? '');
    }

    if (skipBlankLines) lines.removeWhere(isBlank);

    for (var i = 1; i <= lines.length; i++) {
      if (displayLinesNumber) {
        stdout.writeln(_lineWithNumberPreffix(lines[i - 1], i, lines.length));
      } else {
        stdout.writeln(lines[i - 1]);
      }
    }
    stdout.writeln();
  }
}

String _lineWithNumberPreffix(
  String line,
  int lineNumber,
  int lastLineNumber,
) {
  final blankSpacesToAdd =
      lastLineNumber.toString().length - lineNumber.toString().length + 1;

  final buffer = StringBuffer()
    ..writeAll([
      lineNumber,
      ' ' * blankSpacesToAdd,
      line,
    ]);

  return buffer.toString();
}
