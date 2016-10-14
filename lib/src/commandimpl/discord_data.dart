import 'package:discord/discord.dart';

import 'package:lunabot/src/commands.dart';
import 'package:lunabot/src/lunabot.dart' show LunaBot;

Command lsuser = new Command('lsuser')
  ..withDescription('Prints the IDs of each user in the current guild.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(ctx.guild.members.list.map((member) => member.id));
  });

Command name = new Command('name')
  ..withDescription('Prints the usernames associated with the passed IDs.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(args.map((id) => ctx.guild.members.list.firstWhere((member) => member.id == id)).map((member) => '**${member.username}**#${member.discriminator}'));
  });

Command nick = new Command('nick')
  ..withDescription('Prints the nicknames associated with the passed IDs.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(args.map((id) => ctx.guild.members.list.firstWhere((member) => member.id == id)).map((member) => member.nickname));
  });

List<Command> provided = [lsuser, name, nick];