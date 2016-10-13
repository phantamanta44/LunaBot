import 'package:discord/discord.dart';

import 'package:lunabot/src/lunabot.dart' show LunaBot;

class Commander {
  List<Command> commands;
  Map<String, int> aliases;
  LunaBot bot;

  Commander(this.bot) {
    this.commands = [];
    this.aliases = {};
  }

  void register(Command cmd) {
    final int ind = commands.length;
    commands.add(cmd);
    cmd.aliases.forEach((alias) => aliases[alias] = ind);
  }

  void parse(MessageEvent e) {
    String text = e.message.content;
    if (text.startsWith(bot.config['prefix'])) {
      // TODO Implement
    }
  }
}

class Command {
  final String name;
  String desc;
  Function exec;
  List<String> aliases;

  Command(this.name) {
    this.aliases = [];
  }

  void withDescription(String desc) {
    this.desc = desc;
  }

  void withExecutor(Function exec) {
    this.exec = exec;
  }

  void withAlias(String alias) => this.aliases.add(alias);
}