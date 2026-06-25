import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../unit_details/view/unit_details_screen.dart';
import '../controller/property_file_bloc.dart';
import '../model/property_file_model.dart';
import 'widgets/property_file_header_widget.dart';
import 'widgets/unit_card.dart';
import 'widgets/units_filter_tab_bar.dart';

class PropertyFileScreen extends StatelessWidget {
  const PropertyFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PropertyFileBloc()..add(const PropertyFileLoad()),
      child: const _PropertyFileView(),
    );
  }
}

class _PropertyFileView extends StatelessWidget {
  const _PropertyFileView();

  @override
  Widget build(BuildContext context) {
    final bloc = PropertyFileBloc.get(context);
    final colors = AppThemeColors.of(context);

    return BlocListener<PropertyFileBloc, PropertyFileState>(
      listenWhen: (prev, curr) => curr.isDeleted && !prev.isDeleted,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        appBar: AppAppbar(
          title: 'ملف العقار',
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'delete') {
                  _confirmDelete(context, bloc);
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete_outline, color: AppColors.errorColor),
                      SizedBox(width: 8.width),
                      Text(
                        'حذف العقار',
                        style: TextStyle(
                          color: AppColors.errorColor,
                          fontFamily: AppConstant.appFont,
                          fontSize: context.responsiveFontScale(14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<PropertyFileBloc, PropertyFileState>(
          builder: (context, state) {
            return LoadingProcess(
              status: state.status,
              errorMsg: state.errorMsg,
              onTapRefresh: () => bloc.add(const PropertyFileLoad()),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: state.property == null
                  ? const SizedBox()
                  : _PropertyFileContent(
                      property: state.property!,
                      colors: colors,
                      state: state,
                      bloc: bloc,
                    ),
            );
          },
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, PropertyFileBloc bloc) {
    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف العقار'),
        content: const Text('هل أنت متأكد من حذف هذا العقار؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(const PropertyFileDeleteProperty());
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: AppColors.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyFileContent extends StatelessWidget {
  const _PropertyFileContent({
    required this.property,
    required this.colors,
    required this.state,
    required this.bloc,
  });

  final PropertyFileModel property;
  final AppThemeColors colors;
  final PropertyFileState state;
  final PropertyFileBloc bloc;

  @override
  Widget build(BuildContext context) {
    final units = state.filteredUnits;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 16.height, 16.width, 0),
          sliver: SliverToBoxAdapter(
            child: PropertyFileHeaderWidget(
              property: property,
              colors: colors,
              onBookmarkTap: () => bloc.add(const PropertyFileToggleBookmark()),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 20.height, 16.width, 8.height),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${property.rentedCount} مؤجرة من ${property.totalUnits}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
                Text(
                  'الشقق',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    color: colors.textFieldTitle,
                    fontFamily: AppConstant.appHeaderFont,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 0, 16.width, 8.height),
          sliver: SliverToBoxAdapter(
            child: UnitsFilterTabBar(
              colors: colors,
              selected: state.unitFilter,
              rentedCount: property.rentedCount,
              vacantCount: property.vacantCount,
              onFilterChanged: (s) =>
                  bloc.add(PropertyFileFilterChanged(s)),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 0, 16.width, 24.height),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final unit = units[index];
                return UnitCard(
                  unit: unit,
                  colors: colors,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UnitDetailsScreen(
                        unit: unit,
                        propertyName: property.name,
                      ),
                    ),
                  ),
                );
              },
              childCount: units.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.78,
            ),
          ),
        ),
      ],
    );
  }
}
