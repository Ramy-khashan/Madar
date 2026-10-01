import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/components/image_preview_screen.dart';
import '../../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/business_project_details_bloc.dart';
import 'smart_note_item.dart';

class ProjectAttachmentsSectionWidget extends StatelessWidget {
  const ProjectAttachmentsSectionWidget({
    super.key,
    required this.smartNotes,
    this.attachmentUrl,
  });

  final List<String> smartNotes;
  final List<List<String>>? attachmentUrl;

  static const List<bool> _noteHasPdf = [false, false, false, true];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return OutlinedSection(
      title: AppStrings.attachmentsSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...(attachmentUrl ?? []).map(
            (item) => Wrap(
              children: [
                ...List.generate(item.length, (i) {
                  final url = item[i];
                  return Padding(
                    padding: EdgeInsets.only(right: 8.width, bottom: 8.height),
                    child: GestureDetector(
                      onTap: url.isEmpty
                          ? null
                          : () => ImagePreviewScreen.open(
                              context,
                              imageUrl: url,
                              images: ImagePreviewScreen.previewable(item),
                            ),
                      child: ImageItem(
                        url.isNotEmpty ? url : AppImages.attachmentIcon,
                        width: 80.width,
                        height: 80.width,
                        borderRadius: BorderRadius.circular(12.radius),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          if (smartNotes.isNotEmpty) ...[
            SizedBox(height: 16.height),
            Text(
              AppStrings.smartNotesLabel,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w600,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 16.height),
            ...List.generate(smartNotes.length, (i) {
              final isPdf = i < _noteHasPdf.length && _noteHasPdf[i];
              return SmartNoteItem(
                note: smartNotes[i],
                isPdfNote: isPdf,
                colors: colors,
              );
            }),
          ],
          SizedBox(height: 16.height),
          BlocBuilder<BusinessProjectDetailsBloc, BusinessProjectDetailsState>(
            buildWhen: (previous, current) =>
                previous.exportStatus != current.exportStatus,
            builder: (context, state) {
              return AppButton(
                text: AppStrings.downloadPdfReport,
                height: 46,
                textSize: 15,
                isLoading: state.exportStatus == RequestStatus.loading,
                onTap: () => context.read<BusinessProjectDetailsBloc>().add(
                  const BusinessProjectDetailsExportPdf(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
