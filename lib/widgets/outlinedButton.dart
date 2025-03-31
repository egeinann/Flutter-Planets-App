import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  _CustomOutlinedButtonState createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Transform.scale(
        scale: _isPressed ? 0.95 : 1.0,
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: SpaceColors.backgroundColor.withOpacity(0.5),
              width: 2,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: SpaceColors.secondaryColor.withOpacity(0.8),
            elevation: 2,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
