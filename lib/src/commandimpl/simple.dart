import 'package:discord/discord.dart';

import 'package:lunabot/src/commands.dart';
import 'package:lunabot/src/lunabot.dart' show LunaBot;

Command echo = new Command('echo')
  ..withDescription('Prints the provided arguments.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return [args.join(' ')];
  });

List<Command> provided = [echo];