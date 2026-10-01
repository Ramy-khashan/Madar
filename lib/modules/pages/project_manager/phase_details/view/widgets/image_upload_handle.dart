import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../business/real_estate_development/add_project/shared/widgets/file_upload_widget.dart';
import '../../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import '../../controller/phase_details_bloc.dart';
import 'image_grid.dart';

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
              ImageGrid(
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
            if (timeline.every((e) => (e.attachments ?? []).isEmpty))
              ...timeline.map(
                (e) => ImageGrid(
                  bloc: bloc,
                  tc: tc,
                  imagePaths: e.attachments ?? <String>[],
                  isReadOnly: true,
                ),
              ),
          ],
        );
      },
    );
  }
}
