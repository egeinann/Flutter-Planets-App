import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SpacePhoneNumberTextField extends StatefulWidget {
  final TextEditingController controller;

  const SpacePhoneNumberTextField({
    super.key,
    required this.controller,
  });

  @override
  State<SpacePhoneNumberTextField> createState() => _SpacePhoneNumberTextFieldState();
}

class _SpacePhoneNumberTextFieldState extends State<SpacePhoneNumberTextField> {
  @override
  void dispose() {
    // Controller'ı dispose ediyoruz
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
        controller: widget.controller,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Sadece rakam girişi
          // Telefon numarası maskesi
          MaskTextInputFormatter(
            mask: '(###) ###-####', // Maskelenmiş format
            filter: {"#": RegExp(r'[0-9]')},
          ),
        ],
        decoration: InputDecoration(
          hintText: '(###) ###-####',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: SpaceColors.secondaryColor,
              ),
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
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: SpaceColors.firstColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      ),
    );
  }
}
