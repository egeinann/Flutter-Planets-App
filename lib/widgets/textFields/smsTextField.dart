import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class SpaceSmsTextField extends StatelessWidget {
  final TextEditingController controller;
  final int pinLength;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const SpaceSmsTextField({
    super.key,
    required this.controller,
    this.pinLength = 6,
    this.autoFocus = false,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(pinLength, (index) {
          return SizedBox(
            width: 50,
            height: 60,
            child: TextFormField(
              controller: controller,
              maxLength: 1,
              keyboardType: keyboardType ?? TextInputType.number,
              autofocus: autoFocus && index == 0,
              textAlign: TextAlign.center,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                counterText: '',
                hintText: '-',
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
                    color: SpaceColors.firstColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: SpaceColors.secondaryColor,
                    width: 2,
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }),
      ),
    );
  }
}
