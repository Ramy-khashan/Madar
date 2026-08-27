import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../controller/add_property_bloc.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.path,
    required this.index,
    required this.tc,
  });
  final String path;
  final int index;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              color: tc.borderColor.withValues(alpha: 0.3),
              child: Icon(Icons.broken_image_rounded, color: tc.textSecondary),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () =>
                AddPropertyBloc.get(context).add(RemoveImageEvent(index)),
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
