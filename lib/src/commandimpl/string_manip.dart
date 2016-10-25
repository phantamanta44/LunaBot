import 'package:args/args.dart';
import 'package:discord/discord.dart';

import 'package:lunabot/src/commands.dart';
import 'package:lunabot/src/lunabot.dart' show LunaBot;

ArgParser widenParser = new ArgParser()
  ..addOption('spaces', abbr: 'n', defaultsTo: '1');
Command widen = new Command('widen')
  ..withDescription('Makes text A E S T H E T I C.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    ArgResults parsed = widenParser.parse(args);
    int spaceCount = int.parse(parsed['spaces']);
    StringBuffer spaceBuf = new StringBuffer();
    for (int i = 0; i < spaceCount; i++)
      spaceBuf..write(' ');
    String spaces = spaceBuf.toString();
    return stdin.join().replaceAll(new RegExp(r'\s+'), '').runes.join(spaces);
  });

List<Command> provided = [widen];