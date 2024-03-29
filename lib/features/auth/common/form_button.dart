import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../../../utility.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color: disabled
              ? isDarkMode(context)
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              : Theme.of(context).primaryColor,
        ),
        duration: const Duration(
          milliseconds: 500,
        ),
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16,
            color: disabled ? Colors.grey.shade400 : Colors.white,
          ),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: const Text(
            "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}