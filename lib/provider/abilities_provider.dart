import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/abilities_entity.dart';
import 'package:rpg/utility/role_data.dart';

final abilitiesProvider = StateNotifierProvider<AbilitiesNotifier, AbilitiesEntity>((ref) => AbilitiesNotifier());

class AbilitiesNotifier extends StateNotifier<AbilitiesEntity> {
  AbilitiesNotifier() : super(AbilitiesEntity());

  void generate({required List<int> option}) async {
    state = AbilitiesEntity();
    AbilitiesEntity newCharacter = AbilitiesEntity();
    newCharacter = (option[0] == 0 && option[1] == 3 && option[2] == 3) ? gmAbility : adventurerAbility;
    Future.delayed(const Duration(seconds: 3), () => state = newCharacter);
  }
}
