import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class NoteContentField extends StatelessWidget {
  final TextEditingController controller;

  const NoteContentField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      expands: false,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.primaryText,
        height: 1.4,
      ),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
        border: InputBorder.none,
        hintText: 'Start writing...',
        hintStyle: TextStyle(color: AppColors.secondaryText),
        isCollapsed: false,
      ),
    );
  }
}