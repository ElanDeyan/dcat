import 'package:args/args.dart';

/// Builds an instance of [ArgParser] already configured
ArgParser buildParser() {
  return ArgParser()
    ..addMultiOption(
      'files',
      abbr: 'f',
      defaultsTo: const [''],
      help: '''
Files to be processed.
Can be a dash or an empty string to read standard input.
''',
      valueHelp: "file.txt|-|''",
    )
    ..addFlag(
      'display-lines-number',
      abbr: 'n',
      help: 'Whether displays the line number at left.',
    )
    ..addFlag(
      'skip-blank-lines',
      abbr: 'b',
      help: 'Whether ignores blank lines.',
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
