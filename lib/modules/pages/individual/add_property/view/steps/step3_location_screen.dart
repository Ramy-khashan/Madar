import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/image_item.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/model/google_map_model.dart';
import '../../../../../../core/repository/maps/map_service.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/service_locator.dart';
import '../../controller/add_property_bloc.dart';

class AddPropertyStep3Screen extends StatelessWidget {
  const AddPropertyStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
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
                _SectionLabel(label: 'الموقع والصك', tc: tc),
                4.height.toSizedBox,

                Text(
                  'حدد موقع العقار واضف بيانات الصك',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w400,
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.locationSearchController,
                  hint: 'ابحث عن حي ، مدينة ، شارع',
                  prefixImage: AppImages.searchIcon,
                  onChanged: (v) => bloc.add(UpdateLocationEvent(v)),
                ),
                16.height.toSizedBox,
                _MapWidget(),
                16.height.toSizedBox,
                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  buildWhen: (prev, curr) =>
                      prev.model.location != curr.model.location,
                  builder: (context, state) {
                    if (state.model.location == null ||
                        state.model.location!.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return _LocationCard(
                      location: state.model.location!,
                      tc: tc,
                    );
                  },
                ),
                 AppTextField(
                  controller: bloc.buildingNumberController,
                  hint: 'رقم المبنى',
                  title: 'رقم المبنى',
                  textInputType: TextInputType.number,
                  prefixImage:AppImages.floor ,

                ),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.streetController,
                  hint: 'اسم الشارع',
                  title: 'الشارع',
                  prefixImage:AppImages.locationDone ,
                ),
                24.height.toSizedBox,
                Row(children: [
                  Container(
                    width: 40.width,
                    height: 40.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:AppThemeColors.of(context).activeColor
                    ),
                    child: ImageItem(
                      AppImages.instrument,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.width),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
'الصك',
  style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              fontWeight: FontWeight.w600,
                              color: tc.primaryBrand,
                            ),

                            ),

                          Text(
                            'اختر نوع السك وادخل بياناته',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(12),
                              fontWeight: FontWeight.w400,
                              color: tc.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),  
                ],),
                 12.height.toSizedBox,
                const _DeedTypeSelector(),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.deedNumberController,
                  hint: 'ادخل رقم الصك',
                  prefixImage: AppImages.instrument,
                  title: 'رقم الصك',
                  textInputType: TextInputType.number,
                ),
                12.height.toSizedBox,
                _SectionLabel(label: 'تاريخ الصك', tc: tc),
                8.height.toSizedBox,
                const _DateTypeToggle(),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.dateController,
                  hint: 'ادخل التاريخ - هجري',
                  prefixIcon: Icons.calendar_today_rounded,
                  textInputType: TextInputType.datetime,
                ),
                20.height.toSizedBox,
              ],
            ),
          ),
        ),
        _Step3Buttons(tc: tc),
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

class _MapWidget extends StatefulWidget {
  const _MapWidget();

  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget> {
  PositionModel? _selected;

  Future<String?> _reverseGeocode(double lat, double lon) async {
    try {
      final response = await sl.get<Dio>().get<Map<String, dynamic>>(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'format': 'json',
          'lat': lat,
          'lon': lon,
          'accept-language': 'ar',
        },
        options: Options(headers: {'User-Agent': 'MadarApp/1.0'}),
      );
      final addr = response.data?['address'] as Map<String, dynamic>?;
      if (addr == null) return null;

      final neighbourhood =
          (addr['neighbourhood'] ?? addr['suburb'] ?? '').toString();
      final city =
          (addr['city'] ?? addr['town'] ?? addr['village'] ?? '').toString();
      final road = (addr['road'] ?? addr['street'] ?? '').toString();
      final house = (addr['house_number'] ?? '').toString();

      final line1 = [neighbourhood, city]
          .where((s) => s.isNotEmpty)
          .join('، ');
      final line2 =
          [road, house].where((s) => s.isNotEmpty).join(' ');

      return [line1, line2].where((s) => s.isNotEmpty).join('\n');
    } catch (_) {
      return null;
    }
  }

  Future<void> _onMapTap(PositionModel pos, BuildContext context) async {
    setState(() => _selected = pos);
    final bloc = AddPropertyBloc.get(context);
    // Show fallback coordinates immediately
    bloc.add(UpdateLocationEvent(
      '${pos.position.latitude.toStringAsFixed(5)}, ${pos.position.longitude.toStringAsFixed(5)}',
    ));
    // Replace with human-readable address once resolved
    final address = await _reverseGeocode(
      pos.position.latitude,
      pos.position.longitude,
    );
    if (address != null && mounted) {
      AddPropertyBloc.get(context).add(UpdateLocationEvent(address));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          border: Border.all(color: tc.borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: sl.get<MapService>().buildMap(
            onTap: (pos) => _onMapTap(pos, context),
            markers: _selected == null
                ? const {}
                : {
                    MarkerModel(
                      markerId: 'property_location',
                      position: _selected!,
                    ),
                  },
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.location, required this.tc});
  final String location;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    final lines = location.split('\n');
    final line1 = lines.isNotEmpty ? lines[0] : location;
    final line2 = lines.length > 1 ? lines[1] : null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: tc.primaryBrand.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tc.primaryBrand.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Padding(
            padding: EdgeInsets.only(top: 10.height),
            child: Icon(
              Icons.location_on_rounded,
              color: tc.primaryBrand,
              size: 20,
            ),
          ),
          SizedBox(width: 10.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line1,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontWeight: FontWeight.w600,
                    color: tc.textPrimary,
                  ),
                ),
                if (line2 != null && line2.isNotEmpty) ...[
                  SizedBox(height: 2.height),
                  Text(
                    line2,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: tc.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
           Icon(
            Icons.edit,
            color: tc.primaryBrand,
            size: 20,
                       ),
        ],
      ),
    );
  }
}

class _DeedTypeSelector extends StatelessWidget {
  const _DeedTypeSelector();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.model.deedType != curr.model.deedType,
      builder: (context, state) {
        final deedTypes = AddPropertyBloc.deedTypes;
        return Column(
          spacing: 8,
          children: deedTypes.map((deed) {
            final isSelected = state.model.deedType == deed['id'];
            return GestureDetector(
              onTap: () => AddPropertyBloc.get(
                context,
              ).add(SelectDeedTypeEvent(deed['id']!)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 12.height,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? tc.primaryBrand : tc.borderColor,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.width,
                      height: 40.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ImageItem(
                        deed['icon'] as String,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    10.width.toSizedBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            deed['label']!,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(13),
                              fontWeight: FontWeight.w700,
                              color: tc.primaryBrand,
                            ),
                          ),
                          4.height.toSizedBox,
                          Text(
                            deed['hint']!,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(10),
                              fontWeight: FontWeight.w400,
                              color: tc.primaryBrand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _DateTypeToggle extends StatelessWidget {
  const _DateTypeToggle();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.model.dateType != curr.model.dateType,
      builder: (context, state) {
        final isGregorian = state.model.dateType == 'gregorian';
        return Container(
          decoration: BoxDecoration(
            color: tc.borderColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.all(3),
          child: Row(
            children: [
              _DateTypeOption(
                label: 'ميلادي',
                isActive: isGregorian,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectDateTypeEvent('gregorian')),
                tc: tc,
              ),
              _DateTypeOption(
                label: 'هجري',
                isActive: !isGregorian,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectDateTypeEvent('hijri')),
                tc: tc,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateTypeOption extends StatelessWidget {
  const _DateTypeOption({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.tc,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          height: 38,
          decoration: BoxDecoration(
            color: isActive ? tc.primaryBrand : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontWeight: FontWeight.w700,
              color: isActive ? tc.onPrimary : tc.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _Step3Buttons extends StatelessWidget {
  const _Step3Buttons({required this.tc});
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
