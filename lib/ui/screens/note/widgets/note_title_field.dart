import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class NoteTitleField extends StatelessWidget {
  final TextEditingController controller;

  const NoteTitleField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
      ),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
        border: InputBorder.none,
        hintText: 'Note title',
        hintStyle: TextStyle(color: AppColors.secondaryText),
      ),
    );
  }
}