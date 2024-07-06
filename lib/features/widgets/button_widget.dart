import 'package:ayna_task/core/constants/decorations_constants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.buttonText,
    this.onTap,
  });

  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, isHovered, child) {
          return GestureDetector(
            onTap: onTap,
            child: Opacity(
              opacity: isHovered ? 0.8 : 1.0,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: DecorationConstants.borderRadius,
                  gradient: const LinearGradient(colors: [
                    Color(0xFF5051F9),
                    Color(0xFF1EA7FF),
                  ]),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
