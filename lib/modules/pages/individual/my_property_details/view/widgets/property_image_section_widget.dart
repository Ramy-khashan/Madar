import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/my_property_details_bloc.dart';
import '../../model/property_details_model.dart';

class PropertyImageSectionWidget extends StatelessWidget {
  const PropertyImageSectionWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final images = property?.imageUrls ?? [];
    final bloc = context.read<MyPropertyDetailsBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(MyPropertyDetailsImageViewStarted(imageCount: images.length));
    });

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.radius),
      child: Stack(
        children: [
          SizedBox(
            height: 200.height,
            width: double.infinity,
            child: PageView.builder(
              controller: bloc.pageController,
              itemCount: images.length,
              onPageChanged: (page) =>
                  bloc.add(MyPropertyDetailsPageChanged(page: page)),
              itemBuilder: (_, i) => ImageItem(
                images[i],
                height: 200.height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 12.height,
            left: 12.width,
            child: BlocBuilder<MyPropertyDetailsBloc, MyPropertyDetailsState>(
              buildWhen: (prev, curr) =>
                  prev.property?.isBookmarked != curr.property?.isBookmarked,
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
                      state.property?.isBookmarked == true
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 24.width,
                      color: colors.primaryBrand,
                    ),
                  ),
                );
              },
            ),
          ),

          if (images.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12.height,
              child: BlocBuilder<MyPropertyDetailsBloc, MyPropertyDetailsState>(
                buildWhen: (prev, curr) =>
                    prev.currentImagePage != curr.currentImagePage,
                builder: (_, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      final isSelected = index == state.currentImagePage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.width),
                        padding: EdgeInsets.all(isSelected ? 1.width : 0),
                        width: isSelected ? 12.width : 8.width,
                        height: isSelected ? 12.width : 8.width,
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(
                                  color: colors.onPrimary,
                                  width: 1.5.width,
                                )
                              : null,
                          color: isSelected
                              ? Colors.transparent
                              : colors.textFieldHint,
                          shape: BoxShape.circle,
                        ),
                        child: isSelected
                            ? CircleAvatar(backgroundColor: colors.onPrimary)
                            : null,
                      );
                    }),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
