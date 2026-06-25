import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../model/project_model.dart';
import '../../controller/phase_details_bloc.dart';

class ImagesSection extends StatelessWidget {
  const ImagesSection({super.key, 
    required this.phase,
    required this.tc,
    required this.bloc,
  });
  final PhaseModel phase;
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final isRequired = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.images,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w700,
                color: tc.textPrimary,
              ),
            ),
            if (isRequired) ...[
              SizedBox(width: 6.width),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.width,
                  vertical: 2.height,
                ),
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  AppStrings.required,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(10),
                    fontWeight: FontWeight.w600,
                    color: AppColors.errorColor,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 12.height),
        if (phase.imagePaths.isEmpty)
          _UploadArea(tc: tc, bloc: bloc)
        else
          _ImageGrid(imagePaths: phase.imagePaths, tc: tc, bloc: bloc),
      ],
    );
  }
}

class _UploadArea extends StatelessWidget {
  const _UploadArea({required this.tc, required this.bloc});
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.add(const AddPhaseImageEvent('assets/images/property.png'));
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: tc.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tc.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 32,
              color: tc.textSecondary,
            ),
            SizedBox(height: 10.height),

            Text(
              'انقر لتحميل الصور',
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: tc.textPrimary,
              ),
            ),
            SizedBox(height: 4.height),
            Text(
              'أو اسحب الصور هنا',
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: tc.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({
    required this.imagePaths,
    required this.tc,
    required this.bloc,
  });
  final List<String> imagePaths;
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;

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
        return _ImageTile(path: imagePaths[i], index: i, tc: tc, bloc: bloc);
      },
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({
    required this.path,
    required this.index,
    required this.tc,
    required this.bloc,
  });
  final String path;
  final int index;
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, _, _) => Container(
              color: tc.borderColor.withValues(alpha: 0.3),
              child: Icon(Icons.image_rounded, color: tc.textSecondary),
            ),
          ),
        ),
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
