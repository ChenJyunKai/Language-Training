import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/abilities_entity.dart';
import 'package:rpg/utility/role_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

final abilitiesProvider = StateNotifierProvider<AbilitiesNotifier, AbilitiesEntity>((ref) => AbilitiesNotifier());

class AbilitiesNotifier extends StateNotifier<AbilitiesEntity> {
  AbilitiesNotifier() : super(AbilitiesEntity());

  void generate({required List<int> option}) async {
    state = AbilitiesEntity();
    AbilitiesEntity newCharacter = AbilitiesEntity();
    newCharacter = (option[0] == 0 && option[1] == 3 && option[2] == 3) ? gmAbility : adventurerAbility;
    Future.delayed(const Duration(seconds: 3), () => state = newCharacter);
  }

  // 獲取當前角色數據
  void getAbility() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = abilitiesEntityFromJson(prefs.getString('ability')!);
  }

  // 戰鬥後儲存資料
  void improveAbility(AbilitiesEntity lvAbility, AbilitiesEntity ability) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      lv: lvAbility.lv,
      exp: lvAbility.exp,
      expL: lvAbility.expL,
      hp: state.hp + ability.hp,
      mp: state.mp + ability.mp,
      atk: state.atk + ability.atk,
      def: state.def + ability.def,
      agi: state.agi + ability.agi,
      luk: state.luk + ability.luk,
    );
    // 存檔
    await prefs.setString('ability', abilitiesEntityToJson(state));
  }
}
