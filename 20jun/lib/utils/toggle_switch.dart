import 'package:flutter/material.dart';
class ToggleSwitch extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final Duration animationDuration;

  const ToggleSwitch({
    super.key,
    required this.isActive,
    required this.onTap,
    this.animationDuration = const Duration(milliseconds: 300), // Default value

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 20,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isActive ? const Color(0xffFFC0CC) : const Color(0xffD9D9D9),
            width: 0.0,
          ),
          color: isActive ? const Color(0xffFFC0CC) : const Color(0xffD9D9D9),
        ),
        duration: animationDuration,
        child: AnimatedAlign(
          alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
          duration: animationDuration,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xffFE2C55) : const Color(0xffADADAD),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
