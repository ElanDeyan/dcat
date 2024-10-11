import 'dart:io';

import 'package:dcat/build_parser.dart';
import 'package:dcat/constants/version.dart';
import 'package:dcat/core/display_files_content.dart';
import 'package:dcat/print_usage.dart';

void main(List<String> arguments) async {
  final argParser = buildParser();
  try {
    final results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      stdout.writeln('dcat version: $version');
      return;
    }

    final argumentValues = results.multiOption('files');

    await displayFilesContent(
      argumentValues,
      displayLinesNumber: results.flag('display-lines-number'),
      skipBlankLines: results.flag('skip-blank-lines'),
    );
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    stdout.writeln(e.message);
    printUsage(argParser);
  }
}
