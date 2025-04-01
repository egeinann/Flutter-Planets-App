import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SpacePhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  // Maske formatter'ı final olarak tanımlayarak her build'de yeniden oluşturulmasını engelliyoruz
  final maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  SpacePhoneNumberTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          maskFormatter,
        ],
        decoration: InputDecoration(
          hintText: 'Phone number',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: SpaceColors.textColor.withOpacity(0.2),
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
