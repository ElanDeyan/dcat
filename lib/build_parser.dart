import 'package:args/args.dart';
import 'package:dcat/constants/parser/display_lines_number_flag.dart';
import 'package:dcat/constants/parser/files_multi_option.dart';
import 'package:dcat/constants/parser/help_flag.dart';
import 'package:dcat/constants/parser/skip_blank_lines_flag.dart';
import 'package:dcat/constants/parser/version_flag.dart';

/// Builds an instance of [ArgParser] already configured
ArgParser buildParser() {
  return ArgParser()
    ..addMultiOption(
      filesOptionLongName,
      abbr: filesOptionAbbr,
      defaultsTo: const [''],
      help: filesHelpMessage,
      valueHelp: filesValueHelp,
    )
    ..addFlag(
      displayLinesNumberLongName,
      abbr: displayLinesNumberAbbr,
      help: displayLinesNumberHelpMessage,
    )
    ..addFlag(
      skipBlankLinesLongName,
      abbr: skipBlankLinesAbbr,
      help: skipBlankLinesHelpMessage,
    )
    ..addFlag(
      helpLongName,
      abbr: helpAbbr,
      negatable: false,
      help: helpHelpMessage,
    )
    ..addFlag(
      versionLongName,
      abbr: versionAbbr,
      negatable: false,
      help: versionHelpMessage,
    );
}
