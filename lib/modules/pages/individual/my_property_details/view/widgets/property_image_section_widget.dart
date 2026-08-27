import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/property_media_gallery.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_details/model/property_details_model.dart';
import '../../controller/my_property_details_bloc.dart';

class PropertyImageSectionWidget extends StatelessWidget {
  const PropertyImageSectionWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final bloc = context.read<MyPropertyDetailsBloc>();
    final mediaCount = (property?.media ?? []).playable.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(MyPropertyDetailsImageViewStarted(imageCount: mediaCount));
    });

    return PropertyMediaGallery(
      media: property?.media,
      height: 200.height,
      pageController: bloc.pageController,
      onPageChanged: (page) =>
          bloc.add(MyPropertyDetailsPageChanged(page: page)),
      topStart: BlocBuilder<MyPropertyDetailsBloc, MyPropertyDetailsState>(
        builder: (ctx, state) {
          return GestureDetector(
            onTap: () => ctx.read<MyPropertyDetailsBloc>().add(
              const MyPropertyDetailsToggleBookmark(),
            ),
            child: Container(
              padding: EdgeInsets.all(4.width),
              decoration: BoxDecoration(
                color: colors.onPrimary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.bookmark_border,
                size: 24.width,
                color: colors.primaryBrand,
              ),
            ),
          );
        },
      ),
    );
  }
}
