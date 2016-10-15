import 'package:discord/discord.dart';

import 'package:lunabot/src/commands.dart';
import 'package:lunabot/src/lunabot.dart' show LunaBot;

Command lsuser = new Command('lsuser')
  ..withDescription('Prints the IDs of each user in the current guild.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(ctx.guild.members.keys);
  });

Command id = new Command('id')
  ..withDescription('Prints the IDs associated with the passed usernames.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(args.map((arg) {
      if (arg.contains('#')) {
        String name = arg.substring(0, arg.lastIndexOf('#'));
        String discrim = arg.substring(arg.lastIndexOf('#') + 1, arg.length);
        return ctx.guild.members.values.firstWhere((m) => m.username == name && m.discriminator == discrim).id;
      }
      return ctx.guild.members.values.firstWhere((m) => m.username == arg).id;
    }));
  });

Command name = new Command('name')
  ..withDescription('Prints the usernames associated with the passed IDs.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(args.map((id) => ctx.guild.members[id]).map((member) => '**${member.username}**#${member.discriminator}'));
  });

Command nick = new Command('nick')
  ..withDescription('Prints the nicknames associated with the passed IDs.')
  ..withExecutor((List<String> args, Message ctx, LunaBot bot, List<String> stdin) {
    return new List.from(args.map((id) => ctx.guild.members[id]).map((member) => member.nickname ?? member.username));
  });

List<Command> provided = [lsuser, id, name, nick];