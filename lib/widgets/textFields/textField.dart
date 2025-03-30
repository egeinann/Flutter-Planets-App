import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class SpaceTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final bool showSuffixIcon;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const SpaceTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.showSuffixIcon = false,
    this.maxLength,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscureText = ref.watch(_obscureTextProvider(isPassword));

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: SpaceColors.textColor.withOpacity(0.2),
              ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: showSuffixIcon
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => ref
                      .read(_obscureTextProvider(isPassword).notifier)
                      .toggle(),
                )
              : null,
          filled: true,
          fillColor: SpaceColors.backgroundColor.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: SpaceColors.secondaryColor,
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: SpaceColors.firstColor,
              width: 3,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

// ObscureText state'i için Riverpod Provider
final _obscureTextProvider =
    StateProvider.family<bool, bool>((ref, isPassword) {
  return isPassword; // Başlangıç değeri
});

extension ToggleObscureText on StateController<bool> {
  void toggle() => state = !state;
}
