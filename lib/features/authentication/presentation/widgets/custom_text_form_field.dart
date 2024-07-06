import 'package:ayna_task/core/constants/decorations_constants.dart';
import 'package:flutter/material.dart';

///[CustomTextFormField] is a custom text form field widget.
///[CustomTextFormField] is a stateless widget.
///[CustomTextFormField] takes [hintText], [controller], [validator], [autovalidateMode] as parameters.
///[CustomTextFormField] returns a [TextFormField] widget.

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool isPassword;
  final TextInputType keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final ValueNotifier<bool> passwordVisibleNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: passwordVisibleNotifier,
      builder: (context, isPasswordVisible, child) {
        return TextFormField(
          obscureText: widget.isPassword && !isPasswordVisible,
          autovalidateMode: widget.autovalidateMode,
          validator: widget.validator,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          cursorColor: Theme.of(context).colorScheme.secondary,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(top: 18, bottom: 18, left: 14, right: 18),
            errorMaxLines: 2,
            isDense: true,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.labelSmall,
            border: OutlineInputBorder(
              borderRadius: DecorationConstants.borderRadius,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: DecorationConstants.borderRadius,
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        passwordVisibleNotifier.value = !isPasswordVisible,
                  )
                : null,
          ),
        );
      },
    );
  }
}
