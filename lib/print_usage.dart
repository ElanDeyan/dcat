import 'dart:io';

import 'package:args/args.dart';

/// Shows [ArgParser] usage in standard output.
void printUsage(ArgParser argParser) {
  stdout
    ..writeln('Usage: dart dcat.dart <flags> [arguments]')
    ..writeln(argParser.usage);
}
