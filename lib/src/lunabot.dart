import 'dart:io';

import 'package:args/args.dart' show ArgResults;
import 'package:discord/discord.dart' as discord;
import 'package:yaml/yaml.dart';

import 'package:lunabot/src/commands.dart' show Commander;
import 'package:lunabot/src/command_library.dart' as commandlibrary;

class LunaBot {

  String token;
  File configFile;
  var config;
  discord.Client client;
  Commander commands;

  LunaBot(ArgResults args) {
    token = args.options.contains('token') ? args['token'] : null;
    configFile = new File(args.options.contains('config') ? args['config'] : 'lunabot_cfg.yml');
  }

  String init() {
    config = loadYaml(configFile.readAsStringSync());
    if (token == null)
      token = config['token'];
    client = new discord.Client(token, new discord.ClientOptions(disabledEvents: ['MESSAGE_UPDATE']));
    commandlibrary.register(commands = new Commander(this));
    client.onMessage.listen(commands.acceptEvent);
    print('Bot initialized. Waiting for authentication...');
    client.onReady.listen((e) {
      print('Bot authenticated successfully!');
      print('User: ${client.user.username}#${client.user.discriminator}');
      print('UUID: ${client.user.id}');
    });
    return null;
  }

}