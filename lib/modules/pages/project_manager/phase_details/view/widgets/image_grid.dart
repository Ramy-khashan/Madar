import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../controller/phase_details_bloc.dart';
import 'image_tile.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    super.key,
    required this.imagePaths,
    required this.tc,
    required this.bloc,
    this.isReadOnly = true,
  });
  final List<String> imagePaths;
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, i) {
        return ImageTile(
          path: imagePaths[i],
          index: i,
          tc: tc,
          bloc: bloc,
          isReadOnly: isReadOnly,
        );
      },
    );
  }
}
