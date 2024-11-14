import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/ability.dart';
import 'package:rpg/view/setting/components/menu_view.dart';
import 'package:rpg/view/setting/components/rename_view.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    Future.delayed(Duration.zero, () {
      _editingController.text = ref.watch(abilityProvider).userName!;
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MenuView(
            animationController: _animationController,
          ),
          RenameView(
            animationController: _animationController,
            editingController: _editingController,
          ),
        ],
      ),
    );
  }
}
