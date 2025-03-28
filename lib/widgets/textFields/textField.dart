import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class SpaceTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final bool showSuffixIcon;
  final int? length;

  const SpaceTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.showSuffixIcon = false,
    this.length=30,
  });

  @override
  State<SpaceTextField> createState() => _SpaceTextFieldState();
}

class _SpaceTextFieldState extends State<SpaceTextField> {
  late bool obscureText; // Şifre görünürlüğü durumu

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword; // Başlangıçta isPassword değerini al
  }
  
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: TextField(
        maxLength: widget.length,
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: SpaceColors.secondaryColor,
              ),
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.showSuffixIcon
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText; // Durumu değiştir
                    });
                  },
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
              color: SpaceColors.firstColor,
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: SpaceColors.secondaryColor,
              width: 3,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
