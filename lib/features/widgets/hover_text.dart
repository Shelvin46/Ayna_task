import 'package:flutter/material.dart';

class HoverText extends StatelessWidget {
  final ValueNotifier<bool> _isHovering = ValueNotifier(false);

  HoverText({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => _isHovering.value = true,
      onExit: (event) => _isHovering.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovering,
        builder: (context, isHovering, child) {
          return GestureDetector(
            onTap: onTap,
            child: Text(
              "Logout",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: isHovering
                        ? Colors.blue
                        : null, // Change color on hover
                  ),
            ),
          );
        },
      ),
    );
  }
}
