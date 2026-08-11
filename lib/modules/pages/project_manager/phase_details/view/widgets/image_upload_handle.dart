import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
 import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../business/real_estate_development/add_project/shared/widgets/file_upload_widget.dart';
import '../../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import '../../controller/phase_details_bloc.dart';

class ImagesSection extends StatelessWidget {
  const ImagesSection({
    super.key,
    required this.timeline,
    required this.tc,
    required this.bloc,
  });
  final List<Timeline> timeline;
  final AppThemeColors tc;
  final PhaseDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final isRequired = true;
    return BlocBuilder<PhaseDetailsBloc, PhaseDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
 
          
               FileUploadWidget(
                          isRequired: true,
                          title: AppStrings.images,
                          onTap: () async {
                            final paths = await pickImages();
                            if (paths != null && paths.isNotEmpty) {
                              bloc.add(PickImagesEvent(paths));
                            }
                          },
                        ),
            SizedBox(height: 8.height),
            if (state.uploadedImagePaths.isNotEmpty)
              _ImageGrid(
                bloc: bloc,
                tc: tc,
                imagePaths: state.uploadedImagePaths,
                isReadOnly: false,
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.height),
                child: Text(
                  'No images picked yet',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: tc.textSecondary,
                  ),
                ),
              ),
            // SizedBox(height: 12.height),
            // _UploadArea(tc: tc, bloc: bloc),
              if (timeline.every((e) => (e.attachments ?? []).isEmpty))
            ...timeline.map((e) => _ImageGrid(
                  bloc: bloc,
                  tc: tc,
                  imagePaths: e.attachments ?? <String>[],
                  isReadOnly: true,
                )),
           ],
        );
      },
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
      onTap: () async {
        // Handled by FileUploadWidget in screen
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
              AppStrings.clickToUploadPhotos,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: tc.textPrimary,
              ),
            ),
            SizedBox(height: 4.height),
            Text(
              AppStrings.orDragImagesHere,
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
        return _ImageTile(
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

class _ImageTile extends StatelessWidget {
  const _ImageTile({
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
