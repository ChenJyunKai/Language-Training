import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rpg/provider/ability.dart';

class RenameView extends ConsumerStatefulWidget {
  const RenameView({
    Key? key,
    required this.animationController,
    required this.editingController,
  }) : super(key: key);

  final AnimationController animationController;
  final TextEditingController editingController;

  @override
  ConsumerState<RenameView> createState() => _RenameViewState();
}

enum ButtonState { init, loading, done }

class _RenameViewState extends ConsumerState<RenameView> {
  GlobalKey<FormState> key = GlobalKey();
  ButtonState buttonState = ButtonState.init;
  bool isAnimation = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
            parent: widget.animationController,
            curve: Curves.easeIn,
          )),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    '修改角色名稱',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Lottie.asset(
                  'assets/lottie/writer-cat.json',
                  height: 200,
                  width: constraints.maxWidth,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: widget.editingController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: '請輸入新名稱',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    maxLength: 16,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value == "" ? "不可為空" : null,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                AnimatedContainer(
                  padding: const EdgeInsets.only(top: 16),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  width: buttonState == ButtonState.init ? constraints.maxWidth * 0.35 : 60,
                  height: 60,
                  onEnd: () => setState(() => isAnimation = !isAnimation),
                  child: isAnimation || buttonState == ButtonState.init
                      ? _buildButton()
                      : _buildSmallButton(buttonState == ButtonState.done),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () async {
        if (widget.editingController.text == ref.watch(abilityProvider).userName) {
          FocusScope.of(context).requestFocus(FocusNode());
          widget.animationController.reverse();
        } else {
          if (key.currentState!.validate()) {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() => buttonState = ButtonState.loading);
            final isComplite = await ref.read(abilityProvider.notifier).rename(widget.editingController.text);
            if (isComplite) {
              setState(() => buttonState = ButtonState.done);
              await Future.delayed(
                const Duration(milliseconds: 500),
                () => widget.animationController.reverse().then((value) => setState(() => buttonState = ButtonState.init)),
              );
            }
          }
        }
      },
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: widget.editingController.text != ref.watch(abilityProvider).userName ? Colors.green : Colors.grey,
        side: BorderSide(
          color: widget.editingController.text != ref.watch(abilityProvider).userName ? Colors.green : Colors.grey,
        ),
      ),
      child: FittedBox(
        child: Text(
          widget.editingController.text != ref.watch(abilityProvider).userName ? '修改' : '取消',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSmallButton(bool isDone) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: isDone ? Colors.green : Colors.grey),
      child: Center(
        child: isDone
            ? const Icon(Icons.done, color: Colors.white)
            : Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(color: Colors.white),
              ),
      ),
    );
  }
}
