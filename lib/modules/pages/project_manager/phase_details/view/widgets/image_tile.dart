import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../controller/phase_details_bloc.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.path,
    required this.index,
    required this.tc,
    required this.bloc,
    this.isReadOnly = true,
  });
  final String path;
  final int index;
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: isReadOnly || path.startsWith('http')
              ? Image.network(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, _, _) => Container(
                    color: tc.borderColor.withValues(alpha: 0.3),
                    child: Icon(Icons.image_rounded, color: tc.textSecondary),
                  ),
                )
              : Image.file(
                  File(path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, _, _) => Container(
                    color: tc.borderColor.withValues(alpha: 0.3),
                    child: Icon(Icons.image_rounded, color: tc.textSecondary),
                  ),
                ),
        ),
        if (!isReadOnly)
          Positioned(
            top: 4,
            left: 4,
            child: GestureDetector(
              onTap: () => bloc.add(RemovePhaseImageEvent(index)),
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
