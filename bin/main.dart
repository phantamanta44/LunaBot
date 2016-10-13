import 'dart:io' show exit;

import 'package:args/args.dart' show ArgParser;

import 'package:lunabot/src/lunabot.dart' show LunaBot;

main(List<String> args) {
  ArgParser parser = new ArgParser()
    ..addOption('token', abbr: 't')
    ..addOption('config', abbr: 'c');
  LunaBot lunabot = new LunaBot(parser.parse(args));
  String errorMsg;
  if ((errorMsg = lunabot.init()) != null) {
    print(errorMsg);
    exit(1);
  }
}
