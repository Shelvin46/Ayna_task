import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200,
            maxWidth: 680,
          ),
          child: SingleChildScrollView(child: child),
        ).toCenter().paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
