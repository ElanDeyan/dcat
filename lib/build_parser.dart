import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:dcat/core/exceptions/invalid_argument_exception.dart';
import 'package:dcat/core/types/argument_value.dart';
import 'package:dcat/core/validations/argument_values_on_valid.dart';

/// Builds an instance of [ArgParser] already configured
ArgParser buildParser() {
  return ArgParser()
    ..addMultiOption(
      'files',
      abbr: 'f',
      defaultsTo: const [''],
      help: '''
Files to be processed.
Can be a dash or an empty string to read standard output.
''',
      valueHelp: "file.txt|-|''",
      callback: (arguments) async {
        stdout.writeln('Args: $arguments');
        late final List<DcatArgumentValue> values;
        try {
          values = await Isolate.run(() => argumentValuesOnValid(arguments));
        } on InvalidArgumentException catch (e) {
          stdout.writeln(e.message);
          return;
        }

        if (values.isNotEmpty) {
          for (final argument in values) {
            stdout.writeln();
            switch (argument) {
              case RegularFileArgument(:final file):
                stdout.writeln('${'-' * 5} ${file.path} ${'-' * 5}');
                await for (final bytes in file.openRead()) {
                  stdout.write(utf8.decode(bytes));
                }

              case StandardInputArgument():
                stdout.writeln('${'-' * 5} Standard input ${'-' * 5}');
                await for (final bytes in stdin) {
                  stdout.write(utf8.decode(bytes));
                }
            }
            stdout.writeln();
          }
        }
      },
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}
