import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rpg/entity/ability_entity.dart';
import 'package:rpg/utility/role_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'abilities.g.dart';

@Riverpod(keepAlive: true)
class Abilities extends _$Abilities {
  @override
  FutureOr<AbilityEntity> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('ability') != null) {
      return AbilityEntity.fromJson(jsonDecode(prefs.getString('ability')!));
    } else {
      return const AbilityEntity();
    }
  }

  // 存檔
  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ability', jsonEncode(state.value!.toJson()));
  }

  // 生成角色數據
  void generate({required List<int> option}) async {
    AbilityEntity newCharacter = const AbilityEntity();
    newCharacter = (option[0] == 0 && option[1] == 3 && option[2] == 3) ? gmAbility : adventurerAbility;
    state = await AsyncValue.guard(() async => await Future.delayed(const Duration(seconds: 3), () => newCharacter));
  }

  // 戰鬥後儲存資料
  void improveAbility(AbilityEntity lvAbility, AbilityEntity ability) async {
    state = await AsyncValue.guard(
      () async => state.value!.copyWith(
        lv: lvAbility.lv,
        exp: lvAbility.exp,
        expL: lvAbility.expL,
        hp: state.value!.hp + ability.hp,
        mp: state.value!.mp + ability.mp,
        atk: state.value!.atk + ability.atk,
        def: state.value!.def + ability.def,
        agi: state.value!.agi + ability.agi,
        luk: state.value!.luk + ability.luk,
      ),
    );
    saveData();
  }

  // 修改玩家名稱
  Future<bool> rename(String name) async {
    state = await AsyncValue.guard(
      () async => await Future.delayed(const Duration(seconds: 1), () async => state.value!.copyWith(userName: name)),
    );
    saveData();
    return true;
  }
}
