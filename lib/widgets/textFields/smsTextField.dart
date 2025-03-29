import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class SpaceSmsTextField extends StatefulWidget {
  final TextEditingController controller;
  final int pinLength; // Pin kodu uzunluğu
  final bool autoFocus;

  const SpaceSmsTextField({
    super.key,
    required this.controller,
    this.pinLength = 6, // Varsayılan olarak 6 haneli pin kodu
    this.autoFocus = false,
  });

  @override
  State<SpaceSmsTextField> createState() => _SpaceSmsTextFieldState();
}

class _SpaceSmsTextFieldState extends State<SpaceSmsTextField> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.pinLength, (index) {
          return SizedBox(
            width: 50,
            height: 60,
            child: TextField(
              controller: widget.controller,
              maxLength: 1, // Her bir kutu için 1 karakter alacak
              keyboardType: TextInputType.number,
              autofocus: widget.autoFocus && index == 0,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: '',
                hintText: '-',
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
              ),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: SpaceColors.firstColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
          );
        }),
      ),
    );
  }
}
