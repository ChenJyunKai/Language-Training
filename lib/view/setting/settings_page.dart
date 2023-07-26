import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpg/provider/abilities_provider.dart';
import 'package:rpg/view/setting/components/menu_view.dart';
import 'package:rpg/view/setting/components/rename_view.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );
  final TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      editingController.text = ref.watch(abilitiesProvider).userName!;
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    editingController.dispose();
    super.dispose();
  }

  void renameGetData() {
    editingController.text = ref.watch(abilitiesProvider).userName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: BackButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  animationController.value > 0 ? animationController.animateBack(0) : Navigator.pop(context);
                },
              ),
            ),
          ),
          MenuView(
            animationController: animationController,
            renameSet: renameGetData,
          ),
          RenameView(
            animationController: animationController,
            editingController: editingController,
          ),
        ],
      ),
    );
  }
}
