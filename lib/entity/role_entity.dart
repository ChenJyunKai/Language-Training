class RoleEntity {
  RoleEntity({
    this.imageAsset,
    this.describe,
  });

  final String? imageAsset; // 角色圖片位置
  final String? describe; // 角色敘述

  factory RoleEntity.fromJson(Map<String, dynamic> json) => RoleEntity(
    imageAsset: json["imageAsset"],
    describe: json["describe"],
  );

  Map<String, dynamic> toJson() => {
    "imageAsset": imageAsset,
    "describe": describe,
  };
}
