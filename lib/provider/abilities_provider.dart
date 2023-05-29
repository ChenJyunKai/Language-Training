import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/entity/abilities_entity.dart';

final abilitiesProvider = StateNotifierProvider<AbilitiesNotifier, AbilitiesEntity>((ref) => AbilitiesNotifier());

class AbilitiesNotifier extends StateNotifier<AbilitiesEntity> {
  AbilitiesNotifier() : super(AbilitiesEntity());

  void generate() async {
    state = AbilitiesEntity();
    Future.delayed(const Duration(seconds: 3), () => state = state.copyWith('test'));
  }
}
