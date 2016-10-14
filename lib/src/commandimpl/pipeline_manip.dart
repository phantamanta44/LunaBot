import 'package:args/args.dart';
import 'package:discord/discord.dart';

import 'package:lunabot/src/commands.dart';
import 'package:lunabot/src/lunabot.dart' show LunaBot;

ArgParser grepParser = new ArgParser()
  ..addFlag('ignore-case', abbr: 'i', defaultsTo: false)
  ..addFlag('invert-match', abbr: 'v', defaultsTo: false)
  ..addFlag('word-regexp', abbr: 'w', defaultsTo: false)
  ..addFlag('line-regexp', abbr: 'x', defaultsTo: false);
Command grep = new Command('grep')
  ..withDescription('Filters the piped data with a regexp.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    ArgResults parsed = grepParser.parse(args);
    String pattern = parsed['ignore-case'] ? parsed.rest.join(' ').toLowerCase() : parsed.rest.join(' ');
    RegExp exp;
    if (parsed['line-regexp'])
    exp = new RegExp('^$pattern\$');
    else if (parsed['word-regexp'])
    exp = new RegExp('(?:^|\\s)$pattern(?:\$|\\s)');
    else
    exp = new RegExp('.*$pattern.*');
    if (parsed['ignore-case'])
    stdin = new List.from(stdin.map((s) => s.toLowerCase()));
    if (parsed['invert-match'])
    return stdin..removeWhere(exp.hasMatch);
    return stdin..retainWhere(exp.hasMatch);
  });

List<Command> provided = [grep];