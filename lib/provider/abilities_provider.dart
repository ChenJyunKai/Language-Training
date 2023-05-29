import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/abilities_entity.dart';

final abilitiesProvider = StateNotifierProvider<AbilitiesNotifier, AbilitiesEntity>((ref) => AbilitiesNotifier());

class AbilitiesNotifier extends StateNotifier<AbilitiesEntity> {
  AbilitiesNotifier() : super(AbilitiesEntity());

  void reset(){
    state = AbilitiesEntity();
  }

  Future<String> generate() async{
    return Future<String>.delayed(const Duration(seconds: 2), () => '冒險者');
  }
}
