import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../widgets/ai_price_card.dart';

class AddPropertyStep6Screen extends StatelessWidget {
  const AddPropertyStep6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return BlocListener<AddPropertyBloc, AddPropertyState>(
      listenWhen: (prev, curr) =>
          prev.showPortfolioSheet != curr.showPortfolioSheet,
      listener: (context, state) {
        if (state.showPortfolioSheet) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => BlocProvider.value(
              value: bloc,
              child: const _SavePortfolioSheet(),
            ),
          ).whenComplete(() {
            if (bloc.state.showPortfolioSheet) {
              bloc.add(const HidePortfolioSheetEvent());
            }
          });
        }
      },
      child: Column(
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
                  Text(
                    'السعر والمراجعة',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontWeight: FontWeight.w700,
                      color: tc.textPrimary,
                    ),
                  ),
                  4.height.toSizedBox,
                  Text(
                    'حدد السعر - مدار AI يقترح لك بناء ع السوق',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: tc.textSecondary,
                    ),
                  ),
                  16.height.toSizedBox,
                  const AiPriceCard(),
                  16.height.toSizedBox,
                  _PriceInputSection(controller: bloc.priceController, tc: tc),
                  20.height.toSizedBox,
                  _TitleSection(controller: bloc.titleController, tc: tc),
                  20.height.toSizedBox,
                  const _ServiceCardsRow(),
                  16.height.toSizedBox,
                  _AiGenerateButton(onTap: () {}, tc: tc),
                  12.height.toSizedBox,
                  _DescriptionField(
                    controller: bloc.descriptionController,
                    tc: tc,
                  ),
                  20.height.toSizedBox,

                  const _AdSummaryTable(),
                  32.height.toSizedBox,
                ],
              ),
            ),
          ),
          _Step6Buttons(tc: tc),
        ],
      ),
    );
  }
}

class _PriceInputSection extends StatelessWidget {
  const _PriceInputSection({required this.controller, required this.tc});
  final TextEditingController controller;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 12.height,
          ),
          decoration: BoxDecoration(
            color: tc.primaryBrand.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tc.borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "2,850,000",
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(24),
                    fontWeight: FontWeight.w800,
                    color: tc.textPrimary,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Text(
                'ريال',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: tc.textFieldTitle,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.height),
        Row(
          children: [
            ImageItem(
              AppImages.doneIcon,
              color: AppThemeColors.of(context).textFieldTitle,
              width: 14.width,
              height: 14.width,
            ),
            SizedBox(width: 4.width),
            Text(
              'سعر تنافسي - ضمن النطاق المقترح',
              style: TextStyle(
                fontSize: context.responsiveFontScale(11),
                fontWeight: FontWeight.w500,
                color: AppThemeColors.of(context).textFieldTitle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.controller, required this.tc});
  final TextEditingController controller;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 18.height,
          ),
          decoration: BoxDecoration(
            color: tc.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tc.borderColor),
          ),
          child: Text(
            "فيلا حديثه بحي النرجس اطلاله مفتوحة",
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              color: tc.textPrimary,
            ),
          ),
        ),
        SizedBox(height: 6.height),
        Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: AppThemeColors.of(context).textFieldTitle,
              size: 14.width,
            ),
            SizedBox(width: 4.width),
            Text(
              'سعر تنافسي - ضمن النطاق المقترح',
              style: TextStyle(
                fontSize: context.responsiveFontScale(11),
                fontWeight: FontWeight.w500,
                color: AppThemeColors.of(context).textFieldTitle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceCardsRow extends StatelessWidget {
  const _ServiceCardsRow();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.hasRentInstallment != curr.model.hasRentInstallment ||
          prev.model.hasInsurance != curr.model.hasInsurance,
      builder: (context, state) {
        final tc = AppThemeColors.of(context);
        return Row(
          children: [
            Expanded(
              child: _ServiceCard(
                icon: AppImages.safetyIcon,
                label: 'تأمين العقار',
                subtitle: 'حماية شاملة لعقارك ضد المخاطر',
                isSelected: state.model.hasInsurance,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const ToggleInsuranceEvent()),
                tc: tc,
              ),
            ),
            SizedBox(width: 10.width),

            Expanded(
              child: _ServiceCard(
                icon: AppImages.rentIcon,
                label: 'تقسيط الايجار',
                subtitle: 'تقرير سوقي',
                isSelected: state.model.hasRentInstallment,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const ToggleRentInstallmentEvent()),
                tc: tc,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    required this.tc,
  });
  final String icon;
  final String label;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: isSelected
              ? tc.primaryBrand.withValues(alpha: 0.08)
              : tc.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? tc.primaryBrand : tc.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tc.primaryBrand.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ImageItem(icon, width: 20, color: tc.primaryBrand),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: tc.borderColor),
                  ),
                  child: Icon(
                    isSelected ? Icons.check_rounded : Icons.add_rounded,
                    size: 16,
                    color: isSelected ? tc.primaryBrand : tc.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.height),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w700,
                color: isSelected ? tc.primaryBrand : tc.textPrimary,
              ),
            ),
            SizedBox(height: 2.height),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: context.responsiveFontScale(10),
                color: tc.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _AiGenerateButton extends StatelessWidget {
  const _AiGenerateButton({required this.onTap, required this.tc});
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerEnd,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            Icon(Icons.auto_awesome_rounded, color: tc.primaryBrand, size: 14),
            SizedBox(width: 6.width),
            Text(
              'توليد بال AI',
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w600,
                color: tc.primaryBrand,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({required this.controller, required this.tc});
  final TextEditingController controller;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: tc.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tc.borderColor),
      ),
      child: Text(
        "فيلا حديثه بتصميم معاصر اطلاله مفتوحة، مسبح، خاص قريبه من المدارس",
        style: TextStyle(
          fontSize: context.responsiveFontScale(13),
          color: tc.textFieldTitle,
        ),
      ),
    );
  }
}

class _AdSummaryTable extends StatelessWidget {
  const _AdSummaryTable();

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
        final opLabel = m.operationType == 'sell' ? 'للبيع' : 'للإيجار';
        final locationLine = m.location?.split('\n').first ?? '';
        final roomsValue = [
          if (m.beds > 0) '${m.beds} غرف',
          if (m.baths > 0) '${m.baths} حمام',
        ].join(' - ');

        final rows = <_SummaryRow>[
          _SummaryRow(
            label: 'النوع',
            value: '${_propertyLabel(m.propertyType)} $opLabel',
          ),
          if (locationLine.isNotEmpty)
            _SummaryRow(label: 'الموقع', value: locationLine),
          if (m.area.isNotEmpty)
            _SummaryRow(label: 'المساحة', value: '${m.area} م²'),
          if (roomsValue.isNotEmpty)
            _SummaryRow(label: 'الغرف', value: roomsValue),
          if (m.imagePaths.isNotEmpty)
            _SummaryRow(label: 'الصور', value: '${m.imagePaths.length} صور'),
          if (m.amenities.isNotEmpty)
            _SummaryRow(
              label: 'المميزات',
              value: '${m.amenities.length} مميزات',
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
                  'ملخص الإعلان',
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
                    (e) => _SummaryRowWidget(
                      row: e.value,
                      isLast: e.key == rows.length - 1,
                      tc: tc,
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryRow {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;
}

class _SummaryRowWidget extends StatelessWidget {
  const _SummaryRowWidget({
    required this.row,
    required this.isLast,
    required this.tc,
  });
  final _SummaryRow row;
  final bool isLast;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: tc.textSecondary,
            ),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontWeight: FontWeight.w600,
              color: tc.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Step6Buttons extends StatelessWidget {
  const _Step6Buttons({required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Column(
        children: [
          AppButton(
            text: 'حفظ في ملفاتي العقارية',
            onTap: () => AddPropertyBloc.get(
              context,
            ).add(const ShowPortfolioSheetEvent()),
          ),
          12.height.toSizedBox,
          AppButton(
            text: 'ارسال الى وسيط عقاري',
            isOutline: true,
            onTap: () =>
                AddPropertyBloc.get(context).add(const SendToBrokerEvent()),
          ),
        ],
      ),
    );
  }
}

class _SavePortfolioSheet extends StatelessWidget {
  const _SavePortfolioSheet();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return Container(
      decoration: BoxDecoration(
        color: tc.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        16.width,
        20.height,
        16.width,
        MediaQuery.of(context).viewInsets.bottom + 24.height,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: tc.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          16.height.toSizedBox,
          Text(
            'حفظ في ملفاتي العقارية',
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              color: tc.textPrimary,
            ),
          ),
          4.height.toSizedBox,
          Text(
            'اختر مكان حفظ هذ العقار',
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: tc.textSecondary,
            ),
          ),
          20.height.toSizedBox,
          const _PortfolioModeToggle(),
          16.height.toSizedBox,
          const _PortfolioContent(),
          20.height.toSizedBox,
          AppButton(
            text: 'حفظ',
            onTap: () {
              bloc.add(const ConfirmSaveEvent());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _PortfolioModeToggle extends StatelessWidget {
  const _PortfolioModeToggle();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.isNewFolder != curr.isNewFolder,
      builder: (context, state) {
        return Row(
          children: [
            _ModeOption(
              label: 'حفظ في ملف قديم',
              image: AppImages.instrument,
              hint: "اضف لملف عقاري موجود ",

              isActive: !state.isNewFolder,
              onTap: () => AddPropertyBloc.get(
                context,
              ).add(const SelectPortfolioModeEvent(false)),
              tc: tc,
            ),
            12.width.toSizedBox,

            _ModeOption(
              label: 'حفظ كملف جديد',
              image: AppImages.addIcon,
              hint: "انشئ ملف عقاري جديد",
              isActive: state.isNewFolder,
              onTap: () => AddPropertyBloc.get(
                context,
              ).add(const SelectPortfolioModeEvent(true)),
              tc: tc,
            ),
          ],
        );
      },
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.label,
    required this.hint,
    required this.image,
    required this.isActive,
    required this.onTap,
    required this.tc,
  });
  final String label;
  final String hint;
  final String image;
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
          padding: EdgeInsets.symmetric(vertical: 12.height),
          decoration: BoxDecoration(
            color: isActive
                ? tc.primaryBrand.withValues(alpha: 0.1)
                : tc.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? tc.primaryBrand : tc.borderColor,
              width: isActive ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.height),
                padding: EdgeInsets.all(12.width),
                decoration: BoxDecoration(
                  color: tc.primaryBrand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ImageItem(image),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? tc.primaryBrand : tc.textPrimary,
                ),
              ),
              6.height.toSizedBox,
              Text(
                hint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontWeight: FontWeight.w500,
                  color: tc.textFieldTitle.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioContent extends StatelessWidget {
  const _PortfolioContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.isNewFolder != curr.isNewFolder,
      builder: (context, state) {
        if (state.isNewFolder) {
          return AppTextField(
            controller: AddPropertyBloc.get(context).portfolioNameController,
            hint: 'اسم الملف الجديد',
            title: 'اسم الملف',
            prefixIcon: Icons.folder_outlined,
          );
        }
        return const _ExistingFolderList();
      },
    );
  }
}

class _ExistingFolderList extends StatelessWidget {
  const _ExistingFolderList();

  static const List<Map<String, String>> _folders = [
    {'title': 'عمارة النرجس', 'body': '12 شقة - الرياض'},
    {'title': 'عمارة النرجس', 'body': '12 شقة - الرياض'},
    {'title': 'عمارة النرجس', 'body': '12 شقة - الرياض'},
  ];

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      children: _folders
          .map(
            (folder) => Container(
              margin: EdgeInsets.only(bottom: 8.height),
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 14.height,
              ),
              decoration: BoxDecoration(
                color: tc.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: tc.borderColor),
              ),
              child: Row(
                children: [
                  ImageItem(AppImages.apartment, color: tc.primaryBrand),
                  12.width.toSizedBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          folder['title'] ?? "",
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: tc.textPrimary,
                          ),
                        ),
                        Text(
                          folder['body'] ?? "",
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: tc.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: tc.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

extension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());
}
