import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';
import '../widgets/field_error_text.dart';
import '../../model/add_property_model.dart';

class AddPropertyStep4Screen extends StatelessWidget {
  const AddPropertyStep4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(label: AppStrings.propertyPhotos, tc: tc),
                Text(
                  AppStrings.uploadPhotosHint,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                const _UploadArea(),
                const FieldErrorText(AddPropertyField.images),
                16.height.toSizedBox,
                const _ImageGrid(),
                24.height.toSizedBox,
                Row(
                  children: [
                    Expanded(
                      child: _MediaPickerCard(
                        label: AppStrings.tour360,
                        hint: AppStrings.strongerEngagement,
                        emptyHint: AppStrings.tapToAdd360Tour,
                        icon: Icons.map_outlined,
                        pathSelector: (model) => model.virtualTourPath,
                        onPick: () async {
                          final path = await pickVideo();
                          if (path == null || !context.mounted) return;
                          AddPropertyBloc.get(
                            context,
                          ).add(SetVirtualTourPathEvent(path));
                        },
                        onClear: () => AddPropertyBloc.get(
                          context,
                        ).add(const ClearVirtualTourEvent()),
                      ),
                    ),
                    12.width.toSizedBox,
                    Expanded(
                      child: _MediaPickerCard(
                        label: AppStrings.videoLabel,
                        hint: AppStrings.upTo60Seconds,
                        emptyHint: AppStrings.tapToAddVideo,
                        icon: Icons.videocam_outlined,
                        pathSelector: (model) => model.videoPath,
                        onPick: () async {
                          final path = await pickVideo(
                            maxDuration: const Duration(seconds: 60),
                          );
                          if (path == null || !context.mounted) return;
                          AddPropertyBloc.get(
                            context,
                          ).add(SetVideoPathEvent(path));
                        },
                        onClear: () => AddPropertyBloc.get(
                          context,
                        ).add(const ClearVideoEvent()),
                      ),
                    ),
                  ],
                ),
                20.height.toSizedBox,
              ],
            ),
          ),
        ),
        _Step4Buttons(tc: tc),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.tc});
  final String label;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: context.responsiveFontScale(16),
        fontWeight: FontWeight.w700,
        color: tc.textPrimary,
      ),
    );
  }
}

class _UploadArea extends StatelessWidget {
  const _UploadArea();

  Future<void> _pick(BuildContext context) async {
    final paths = await pickImages();
    if (paths == null || paths.isEmpty || !context.mounted) return;
    AddPropertyBloc.get(context).add(AddImagesEvent(paths));
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return GestureDetector(
      onTap: () => _pick(context),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: tc.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tc.primaryBrand.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageItem(
              AppImages.uploadIcon,
              color: tc.primaryBrand,
              width: 28,
              height: 28,
            ),
            12.height.toSizedBox,
            Text(
              AppStrings.clickToUploadPhotos,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: tc.primaryBrand,
              ),
            ),
            6.height.toSizedBox,
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
  const _ImageGrid();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.model.imagePaths != curr.model.imagePaths,
      builder: (context, state) {
        final paths = state.model.imagePaths;
        if (paths.isEmpty) return const SizedBox.shrink();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: paths.length,
          itemBuilder: (context, i) {
            return _ImageTile(path: paths[i], index: i, tc: tc);
          },
        );
      },
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.path, required this.index, required this.tc});
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

class _MediaPickerCard extends StatelessWidget {
  const _MediaPickerCard({
    required this.label,
    required this.hint,
    required this.emptyHint,
    required this.icon,
    required this.pathSelector,
    required this.onPick,
    required this.onClear,
  });

  final String label;
  final String hint;
  final String emptyHint;
  final IconData icon;
  final String? Function(AddPropertyModel) pathSelector;
  final VoidCallback onPick;
  final VoidCallback onClear;

  String _fileName(String path) {
    final parts = path.split(RegExp(r'[/\\]'));
    return parts.isEmpty ? path : parts.last;
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          pathSelector(prev.model) != pathSelector(curr.model),
      builder: (context, state) {
        final path = pathSelector(state.model);
        final hasFile = path != null && path.isNotEmpty;
        return GestureDetector(
          onTap: onPick,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 12.height,
            ),
            decoration: BoxDecoration(
              color: tc.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasFile ? tc.primaryBrand : tc.borderColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: hasFile ? tc.primaryBrand : tc.textSecondary,
                  size: 28.width,
                ),
                6.height.toSizedBox,
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                    color: tc.primaryBrand,
                  ),
                ),
                8.height.toSizedBox,
                Text(
                  hasFile ? _fileName(path) : emptyHint,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w500,
                    color: hasFile ? tc.textPrimary : tc.textFieldBorder,
                  ),
                ),
                4.height.toSizedBox,
                Text(
                  hasFile ? AppStrings.changeFile : hint,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: tc.textSecondary,
                  ),
                ),
                if (hasFile) ...[
                  8.height.toSizedBox,
                  GestureDetector(
                    onTap: onClear,
                    child: Text(
                      AppStrings.removeFile,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.errorColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Step4Buttons extends StatelessWidget {
  const _Step4Buttons({required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: AppStrings.back,
              isOutline: true,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const PreviousStepEvent()),
            ),
          ),
          12.width.toSizedBox,
          Expanded(
            child: AppButton(
              text: AppStrings.next,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const NextStepEvent()),
            ),
          ),
        ],
      ),
    );
  }
}

extension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());
}
