import 'package:discord/discord.dart';
import 'package:tuple/tuple.dart' show Tuple3;

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
    aliases[cmd.name] = ind;
  }

  void acceptEvent(MessageEvent event) {
    if (event.message.content.startsWith(bot.config['prefix'])) {
      try {
        String source = event.message.guild != null ? event.message.guild.name : 'PM';
        print('$source / ${event.message.author.username}: ${event.message.content}');
        String result = parse(event.message);
        event.message.channel.sendMessage('__${event.message.author.mention}__\n$result');
      } catch (e) {
        event.message.channel.sendMessage('${event.message.author.mention}: $e');
      }
    }
  }

  String parse(Message message) {
    String text = message.content;
    text = text.substring(bot.config['prefix'].length).trim();
    List<String> statements = new List();
    int ind = 0,
        prev = 0,
        prevUnescaped = -1;
    while ((ind = text.indexOf('|', prev + 1)) != -1) {
      if (text[ind - 1] != r'\') {
        statements.add(text.substring(prevUnescaped + 1, ind).trim());
        prevUnescaped = ind;
      }
      prev = ind;
    }
    statements.add(text.substring(prevUnescaped + 1).trim());
    List<Tuple3<Command, List<String>, bool>> runSeq = new List();
    for (String statement in statements) {
      bool xargs;
      List<String> parts = statement.split(new RegExp(r'\s'));
      if (parts.length < 1 || parts[0].isEmpty)
        throw 'Expected a command but found none!';
      if (xargs = parts[0].startsWith('^'))
        parts[0] = parts[0].substring(1);
      if (!aliases.containsKey(parts[0]))
        throw 'No such command "${parts[0]}"!';
      runSeq.add(new Tuple3(commands[aliases[parts[0]]], parts.sublist(1), xargs));
    }
    List<String> output;
    for (Tuple3<Command, List<String>, bool> statement in runSeq) {
      try {
        if (statement.item3)
          output = statement.item1(new List.from(statement.item2)..addAll(output), message, bot, null);
        else
          output = statement.item1(statement.item2, message, bot, output);
      } catch (e) {
        throw '${statement.item1.name}: $e';
      }
    }
    return output.join('\n');
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

  void withExecutor(List<String> exec(List<String> args, Message ctx, LunaBot bot, List<String> stdin)) {
    this.exec = exec;
  }

  void withAlias(String alias) => this.aliases.add(alias);

  List<String> call(List<String> args, Message ctx, LunaBot bot, List<String> stdin) => this.exec(args, ctx, bot, stdin);
}