import 'package:args/args.dart';

void printUsage(ArgParser argParser) {
  print('Usage: dart dcat.dart <flags> [arguments]');
  print(argParser.usage);
}
