import 'package:rpg/entity/abilities_entity.dart';
import 'package:rpg/entity/role_entity.dart';
import 'package:rpg/helper/time_format.dart';

// 冒險者
final adventurerAbility = AbilitiesEntity(
  userName: 'User${TimeFormat().local('hhmmss', DateTime.now())}',
  role: '冒險者',
  roleData: adventurer,
);

final adventurer = RoleEntity(
  imageAsset: 'assets/lottie/cute-tiger.json',
  describe: '「你是獨一無二的，因為我們都不希望再有第二個。」\n— Theodore Roosevelt, 26th U.S. President',
);

// GM
final gmAbility = AbilitiesEntity(
  userName: 'User${TimeFormat().local('hhmmss', DateTime.now())}',
  role: '封弊者',
  roleData: gm,
  lv: 200,
  hp: 99999,
  mp: 99999,
  atk: 9999,
  def: 9999,
  agi: 9999,
  luk: 9999,
);

final gm = RoleEntity(
  imageAsset: 'assets/lottie/gm.json',
  describe: '「沒錯，我就是封弊者，今後請不要將那些菜鳥跟我混為一談。」\n— Kirito, Sword Art Online',
);

/// 經驗曲線公式 floor(((等级-1)^3+60)/5*((等级-1)*2+60)+60,50)
