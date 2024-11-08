import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rpg/entity/ability_entity.dart';
import 'package:rpg/entity/skill_entity.dart';
import 'package:rpg/constants/role_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ability.g.dart';

@Riverpod(keepAlive: true)
class Ability extends _$Ability {
  @override
  AbilityEntity build() {
    return const AbilityEntity();
  }

  // 存檔
  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state != const AbilityEntity()) {
      await prefs.setString('ability', jsonEncode(state.toJson()));
    } else {
      await prefs.remove('ability');
    }
  }

  // 讀檔
  void getAbility() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = AbilityEntity.fromJson(jsonDecode(prefs.getString('ability')!));
  }

  // 生成角色數據
  void generate({required List<int> option}) async {
    AbilityEntity newCharacter = const AbilityEntity();
    newCharacter = (option[0] == 0 && option[1] == 3 && option[2] == 3) ? gmAbility : adventurerAbility;
    await Future.delayed(const Duration(seconds: 2), () => state = newCharacter);
  }

  // 戰鬥後儲存資料
  void improveAbility(AbilityEntity lvAbility, AbilityEntity ability) async {
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
      sp: state.sp + ability.sp,
    );
    saveData();
  }

  // 修改玩家名稱
  Future<bool> rename(String name) async {
    await Future.delayed(const Duration(seconds: 1), () => state = state.copyWith(userName: name));
    saveData();
    return true;
  }

  // 學習技能
  void skillUpgrade(SkillEntity skill) {
    final newSkill = skill.copyWith(level: skill.level + 1);
    state = state.copyWith(
      sp: state.sp - 1,
      skill: state.skill.map((s) => s.skillCode == newSkill.skillCode ? newSkill : s).toList(),
    );
    saveData();
  }

  void removeData() async {
    state = const AbilityEntity();
    saveData();
  }
}
