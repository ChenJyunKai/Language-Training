import 'dart:convert';
import 'package:rpg/entity/role_entity.dart';

AbilitiesEntity abilitiesEntityFromJson(String str) => AbilitiesEntity.fromJson(json.decode(str));

String abilitiesEntityToJson(AbilitiesEntity data) => json.encode(data.toJson());

class AbilitiesEntity {
  AbilitiesEntity({
    this.userName,
    this.role,
    this.roleData,
    this.lv = 1,
    this.exp = 0,
    this.expL = 750,
    this.hp = 200,
    this.mp = 50,
    this.atk = 25,
    this.def = 25,
    this.agi = 10,
    this.luk = 10,
  });

  final String? userName; // 玩家名稱
  final String? role; // 職業
  final RoleEntity? roleData; // 角色資料
  final int lv;
  final int exp;
  final int expL; // 下一級所需要經驗
  final int hp;
  final int mp;
  final int atk;
  final int def;
  final int agi;
  final int luk;

  AbilitiesEntity copyWith(
      {String? role, int? lv, int? exp, int? expL, int? hp, int? mp, int? atk, int? def, int? agi, int? luk}) {
    return AbilitiesEntity(
      userName: userName,
      role: role ?? this.role,
      roleData: roleData,
      lv: lv ?? this.lv,
      exp: exp ?? this.exp,
      expL: expL ?? this.expL,
      hp: hp ?? this.hp,
      mp: mp ?? this.mp,
      atk: atk ?? this.atk,
      def: def ?? this.def,
      agi: agi ?? this.agi,
      luk: luk ?? this.luk,
    );
  }

  factory AbilitiesEntity.fromJson(Map<String, dynamic> json) => AbilitiesEntity(
        userName: json["user_name"],
        role: json["role"],
        roleData: RoleEntity.fromJson(json["role_data"]),
        lv: json["lv"],
        hp: json["hp"],
        mp: json["mp"],
        atk: json["atk"],
        def: json["def"],
        agi: json["agi"],
        luk: json["luk"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "role": role,
        "role_data": roleData!.toJson(),
        "lv": lv,
        "hp": hp,
        "mp": mp,
        "atk": atk,
        "def": def,
        "agi": agi,
        "luk": luk,
      };
}
