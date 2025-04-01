import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class SpaceSmsTextField extends StatefulWidget {
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
  _SpaceSmsTextFieldState createState() => _SpaceSmsTextFieldState();
}

class _SpaceSmsTextFieldState extends State<SpaceSmsTextField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.pinLength, (_) => TextEditingController());
    _focusNodes = List.generate(widget.pinLength, (_) => FocusNode());

    // Ana controller'a başlangıç değeri varsa kutucuklara dağıt
    if (widget.controller.text.isNotEmpty) {
      for (int i = 0;
          i < widget.pinLength && i < widget.controller.text.length;
          i++) {
        _controllers[i].text = widget.controller.text[i];
      }
    }

    // Ana controller'ı güncellemek için dinleyici
    for (var controller in _controllers) {
      controller.addListener(_updateMainController);
    }
  }

  void _updateMainController() {
    String fullCode = _controllers.map((c) => c.text).join();
    widget.controller.text = fullCode;
    widget.onChanged?.call(fullCode);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_updateMainController);
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
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
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              maxLength: 1,
              keyboardType: widget.keyboardType ?? TextInputType.number,
              autofocus: widget.autoFocus && index == 0,
              textAlign: TextAlign.center,
              onChanged: (value) {
                if (value.length == 1 && index < widget.pinLength - 1) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
              },
              validator: widget.validator,
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
