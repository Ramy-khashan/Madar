import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'summary_row_widget.dart';

class _SummaryRow {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;
}

class AdSummaryTable extends StatelessWidget {
  const AdSummaryTable({super.key});

  static String _propertyLabel(String? typeId) {
    if (typeId == null) return '—';
    return AddPropertyBloc.propertyTypeItems.firstWhere(
          (e) => e['id'] == typeId,
          orElse: () => {'label': '—'},
        )['label']
        as String;
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        final m = state.model;
        final opLabel = m.operationType == 'sell'
            ? AppStrings.forSale
            : AppStrings.forRent;
        final locationLine = m.location?.split('\n').first ?? '';
        final roomsValue = [
          if (m.beds > 0) AppStrings.roomsCount(m.beds),
          if (m.baths > 0) AppStrings.bathroomsShort(m.baths),
        ].join(' - ');

        final rows = <_SummaryRow>[
          _SummaryRow(
            label: AppStrings.typeLabel,
            value: '${_propertyLabel(m.propertyType)} $opLabel',
          ),
          if (locationLine.isNotEmpty)
            _SummaryRow(label: AppStrings.locationLabel, value: locationLine),
          if (m.area.isNotEmpty)
            _SummaryRow(
              label: AppStrings.areaLabel,
              value: '${m.area} ${AppStrings.mesurement}',
            ),
          if (roomsValue.isNotEmpty)
            _SummaryRow(label: AppStrings.beds, value: roomsValue),
          if (m.imagePaths.isNotEmpty)
            _SummaryRow(
              label: AppStrings.images,
              value: AppStrings.photosCount(m.imagePaths.length),
            ),
          if (m.virtualTourPath != null && m.virtualTourPath!.isNotEmpty)
            _SummaryRow(
              label: AppStrings.tour360,
              value: m.virtualTourPath!.split(RegExp(r'[/\\]')).last,
            ),
          if (m.videoPath != null && m.videoPath!.isNotEmpty)
            _SummaryRow(
              label: AppStrings.videoLabel,
              value: m.videoPath!.split(RegExp(r'[/\\]')).last,
            ),
          if (m.amenities.isNotEmpty)
            _SummaryRow(
              label: AppStrings.amenitiesLabel,
              value: AppStrings.amenitiesCount(m.amenities.length),
            ),
          if (m.hasParentProperty)
            _SummaryRow(
              label: AppStrings.selectParentBuilding,
              value: m.propertyParentTitle,
            ),
        ];

        return Container(
          decoration: BoxDecoration(
            color: tc.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: tc.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppStrings.adSummary,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    fontWeight: FontWeight.w700,
                    color: tc.textPrimary,
                  ),
                ),
              ),
              ...rows
                  .asMap()
                  .entries
                  .map(
                    (e) => SummaryRowWidget(
                      label: e.value.label,
                      value: e.value.value,
                      isLast: e.key == rows.length - 1,
                      tc: tc,
                    ),
                  )
                  ,
            ],
          ),
        );
      },
    );
  }
}
