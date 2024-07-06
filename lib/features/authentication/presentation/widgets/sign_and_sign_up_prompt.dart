import 'package:flutter/material.dart';

class SignInAndSignUpPrompt extends StatelessWidget {
  const SignInAndSignUpPrompt({
    super.key,
    required this.instruction,
    required this.action,
    required this.onTap,
  });

  final String instruction;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(instruction),
        MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          cursor: SystemMouseCursors.click,
          child: ValueListenableBuilder<bool>(
            valueListenable: isHovered,
            builder: (context, isHovered, child) {
              return GestureDetector(
                onTap: onTap,
                child: Text(
                  action,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isHovered ? Colors.blue : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
