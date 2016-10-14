import 'dart:io' show exit;

import 'package:args/args.dart' show ArgParser;

import 'package:lunabot/src/lunabot.dart' show LunaBot;

main(List<String> args) {
  ArgParser parser = new ArgParser()
    ..addOption('token', abbr: 't')
    ..addOption('config', abbr: 'c');
  LunaBot lunabot = new LunaBot(parser.parse(args));
  try {
    lunabot.init();
  } catch (e) {
    print('Something went wrong!');
    print(e);
    exit(1);
  }
}
