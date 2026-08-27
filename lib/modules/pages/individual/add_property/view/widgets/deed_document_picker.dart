import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class DeedDocumentPicker extends StatelessWidget {
  const DeedDocumentPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.ownershipDocumentPath != curr.model.ownershipDocumentPath,
      builder: (context, state) {
        final path = state.model.ownershipDocumentPath;
        final hasFile = path != null && path.isNotEmpty;
        final fileName = hasFile
            ? path.split(RegExp(r'[/\\]')).last
            : AppStrings.tapToAddDeedDocument;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.ownershipDocumentOptional,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w600,
                color: tc.textFieldTitle,
              ),
            ),
            8.height.toSizedBox,
            InkWell(
              onTap: () async {
                final picked = await pickSingleImage();
                if (picked == null || !context.mounted) return;
                AddPropertyBloc.get(context).add(SetDeedDocumentEvent(picked));
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 14.width,
                  vertical: 14.height,
                ),
                decoration: BoxDecoration(
                  color: tc.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: tc.borderColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_file_rounded,
                      color: tc.primaryBrand,
                      size: 20,
                    ),
                    SizedBox(width: 10.width),
                    Expanded(
                      child: Text(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: tc.textPrimary,
                        ),
                      ),
                    ),
                    if (hasFile)
                      GestureDetector(
                        onTap: () => AddPropertyBloc.get(
                          context,
                        ).add(const ClearDeedDocumentEvent()),
                        child: Text(
                          AppStrings.removeFile,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            color: tc.primaryBrand,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
