import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

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
                _SectionLabel(label: 'صور العقار', tc: tc),
                Text(
                  "ارفع 5 صور ع الاقل - اول صوره هي الواجهة",
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                const _UploadArea(),
                16.height.toSizedBox,
                const _AiEnhancementToggle(),
                16.height.toSizedBox,
                const _ImageGrid(),
                24.height.toSizedBox,
               
                Row(
                  children: [
                     Expanded(
                      child: const _MediaToggleRow(
                        event: Toggle360TourEvent(),
                        field: 'has360Tour',
                        label: 'جولة 360 درجة',
                        hint:"+ تفاعل اقوى",

                        icon: Icons.map_outlined,
                      ),
                    ),
                 
                    12.height.toSizedBox,
                      Expanded(
                      child: const _MediaToggleRow(
                        event: ToggleVideoEvent(),
                        field: 'hasVideo',
                        label: 'فيديو',
                        hint:"حتى 60 ثانية",
                        icon: Icons.camera_alt_outlined,
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

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return GestureDetector(
      onTap: () {
        // TODO: open image picker
      },
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: tc.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tc.primaryBrand.withValues(alpha: 0.4),
            width: 1.5,
            style: BorderStyle.solid,
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
              'انقر لتحميل الصور',
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: tc.primaryBrand,
              ),
            ),
            6.height.toSizedBox,
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

class _AiEnhancementToggle extends StatelessWidget {
  const _AiEnhancementToggle();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.aiEnhancement != curr.model.aiEnhancement,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 2.height,
          ),
          decoration: BoxDecoration(
            color: tc.primaryBrand.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tc.borderColor),
          ),
          child: Row(
            children: [
              ImageItem(
                AppImages.chatbotIcon,
                width: 24,
                height: 24,
                color: tc.primaryBrand,
              ),
              12.width.toSizedBox,
              Expanded(
                child: Text(
                  'تحسين تلقائي بال AI',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontWeight: FontWeight.w600,
                    color: tc.textPrimary,
                  ),
                ),
              ),
              Switch(
                value: state.model.aiEnhancement,
                onChanged: (_) => AddPropertyBloc.get(
                  context,
                ).add(const ToggleAiEnhancementEvent()),
                activeColor: tc.primaryBrand,
              ),
            ],
          ),
        );
      },
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
          child: Image.asset(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Container(
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

class _MediaToggleRow extends StatelessWidget {
  const _MediaToggleRow({
    required this.event,
    required this.field,
    required this.label,
    required this.hint,
    required this.icon,
  });
  final AddPropertyEvent event;
  final String field; // 'hasVideo' | 'has360Tour'
  final String label;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 12.height,
          ),
          decoration: BoxDecoration(
            color: tc.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:   tc.borderColor,
            ),
          ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color:  tc.textSecondary,
                size: 28.width,
              ),
              6.height.toSizedBox,
              Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w600,
                  color:  tc.primaryBrand  ,
                ),
              ), 
              8.height.toSizedBox,
              Text(
                hint,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w600,
                  color:   tc.textFieldBorder  ,
                ),
              ),
             
            ],
          ),
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
              text: 'رجوع',
              isOutline: true,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const PreviousStepEvent()),
            ),
          ),
          12.width.toSizedBox,
          Expanded(
            child: AppButton(
              text: 'التالي',
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
