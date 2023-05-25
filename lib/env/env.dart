import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'openAIKey', obfuscate: true)
  static final String openAIKey = _Env.openAIKey;
}
