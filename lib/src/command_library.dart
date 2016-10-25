import 'package:lunabot/src/commandimpl/discord_data.dart' as discord_data;
import 'package:lunabot/src/commandimpl/pipeline_manip.dart' as pipeline_manip;
import 'package:lunabot/src/commandimpl/simple.dart' as simple;
import 'package:lunabot/src/commandimpl/string_manip.dart' as string_manip;
import 'package:lunabot/src/commands.dart';

void register(Commander registry) {
  discord_data.provided.forEach(registry.register);
  pipeline_manip.provided.forEach(registry.register);
  simple.provided.forEach(registry.register);
  string_manip.provided.forEach(registry.register);
}