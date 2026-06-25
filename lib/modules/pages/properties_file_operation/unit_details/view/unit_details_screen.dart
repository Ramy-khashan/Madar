import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../property_file/model/property_file_model.dart';
import '../controller/unit_details_bloc.dart';
import 'widgets/two_option_toggle.dart';
import 'widgets/unit_expenses_section.dart';
import 'widgets/unit_info_row.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({
    super.key,
    required this.unit,
    required this.propertyName,
  });

  final UnitModel unit;
  final String propertyName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UnitDetailsBloc()..add(UnitDetailsInit(unit)),
      child: _UnitDetailsView(propertyName: propertyName),
    );
  }
}

class _UnitDetailsView extends StatelessWidget {
  const _UnitDetailsView({required this.propertyName});

  final String propertyName;

  @override
  Widget build(BuildContext context) {
    final bloc = UnitDetailsBloc.get(context);
    final colors = AppThemeColors.of(context);

    return BlocListener<UnitDetailsBloc, UnitDetailsState>(
      listenWhen: (prev, curr) =>
          (curr.isDeleted && !prev.isDeleted) ||
          (curr.isSentToBroker && !prev.isSentToBroker),
      listener: (context, state) {
        if (state.isDeleted) {
          Navigator.of(context).pop();
        } else if (state.isSentToBroker) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إرسال الملف إلى وسيط عقاري')),
          );
        }
      },
      child: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
        builder: (context, outerState) => Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(
            title: outerState.unit?.label ?? '',
            actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (val) {
                if (val == 'send') {
                  bloc.add(const UnitDetailsSentToBroker());
                } else if (val == 'delete') {
                  _confirmDelete(context, bloc);
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'send',
                  child: Row(
                    children: [
                      Icon(Icons.send_outlined,
                          color: colors.primaryBrand, size: 18.width),
                      SizedBox(width: 8.width),
                      Text(
                        'ارسال الملف الى وسيط عقاري',
                        style: TextStyle(
                          fontFamily: AppConstant.appFont,
                          fontSize: context.responsiveFontScale(13),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete_outline,
                          color: AppColors.errorColor),
                      SizedBox(width: 8.width),
                      Text(
                        'حذف الملف العقاري',
                        style: TextStyle(
                          color: AppColors.errorColor,
                          fontFamily: AppConstant.appFont,
                          fontSize: context.responsiveFontScale(13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
          builder: (context, state) {
            final unit = state.unit;
            if (unit == null) return const SizedBox();

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  16.width, 16.height, 16.width, 32.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Unit title + property name
                  Text(
                    unit.label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(22),
                      fontWeight: FontWeight.w700,
                      color: colors.textFieldTitle,
                      fontFamily: AppConstant.appHeaderFont,
                    ),
                  ),
                  Text(
                    propertyName,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      color: colors.textSecondary,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                  SizedBox(height: 16.height),

                  // ── Basic info ────────────────────────────────────────────
                  Container(
                    padding: EdgeInsets.all(16.width),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(20.radius),
                      border: Border.all(color: colors.borderColor),
                    ),
                    child: Column(
                      children: [
                        UnitInfoRow(
                          label: 'رقم الشقة',
                          value: unit.number,
                          trailingIcon: Icons.tag,
                          colors: colors,
                          isEditable: true,
                        ),
                        SizedBox(height: 10.height),
                        Row(
                          children: [
                            Expanded(
                              child: UnitInfoRow(
                                label: 'المساحة',
                                value: '${unit.area.toInt()} م2',
                                trailingIcon: Icons.fullscreen,
                                colors: colors,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.height),
                        Row(
                          children: [
                            Expanded(
                              child: UnitInfoRow(
                                label: 'الحمامات',
                                value: '${unit.bathrooms}',
                                trailingIcon: Icons.bathtub_outlined,
                                colors: colors,
                              ),
                            ),
                            SizedBox(width: 10.width),
                            Expanded(
                              child: UnitInfoRow(
                                label: 'الغرف',
                                value: '${unit.rooms}',
                                trailingIcon: Icons.king_bed_outlined,
                                colors: colors,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.height),
                        UnitInfoRow(
                          label: 'الايجار الشهري',
                          value:
                              '${unit.monthlyRent.toStringAsFixed(0)} ريال',
                          trailingIcon: Icons.receipt_long_outlined,
                          colors: colors,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.height),

                  // ── Rental status ─────────────────────────────────────────
                  Text(
                    'حالة الايجار',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(18),
                      fontWeight: FontWeight.w700,
                      color: colors.textFieldTitle,
                      fontFamily: AppConstant.appHeaderFont,
                    ),
                  ),
                  SizedBox(height: 12.height),
                  Container(
                    padding: EdgeInsets.all(16.width),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(20.radius),
                      border: Border.all(color: colors.borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // الحالة label
                        Text(
                          'الحالة',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                        SizedBox(height: 8.height),
                        TwoOptionToggle(
                          leftLabel: 'شاغرة',
                          rightLabel: 'مؤجرة',
                          isRightSelected:
                              unit.status == UnitStatus.rented,
                          colors: colors,
                          onChanged: (isRight) => bloc.add(
                            UnitDetailsStatusToggled(
                              isRight
                                  ? UnitStatus.rented
                                  : UnitStatus.vacant,
                            ),
                          ),
                        ),
                        if (unit.status == UnitStatus.rented) ...[
                          SizedBox(height: 14.height),
                          Text(
                            'نوع التاريخ',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(13),
                              color: colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                          SizedBox(height: 8.height),
                          TwoOptionToggle(
                            leftLabel: 'ميلادي',
                            rightLabel: 'هجري',
                            isRightSelected: unit.isHijriDate,
                            colors: colors,
                            onChanged: (isRight) =>
                                bloc.add(UnitDetailsDateTypeToggled(isRight)),
                          ),
                          SizedBox(height: 12.height),
                          UnitInfoRow(
                            label: 'تاريخ بدء الايجار',
                            value: unit.rentStartDate,
                            trailingIcon: Icons.calendar_today_outlined,
                            colors: colors,
                            controller: bloc.rentStartController,
                          ),
                          SizedBox(height: 10.height),
                          UnitInfoRow(
                            label: 'تاريخ انتهاء الايجار',
                            value: unit.rentEndDate,
                            trailingIcon: Icons.calendar_today_outlined,
                            colors: colors,
                            controller: bloc.rentEndController,
                          ),
                          SizedBox(height: 10.height),
                          UnitInfoRow(
                            label: 'اسم المستأجر',
                            value: unit.tenantName,
                            trailingIcon: Icons.person_outline,
                            colors: colors,
                            controller: bloc.tenantNameController,
                          ),
                          SizedBox(height: 10.height),
                          UnitInfoRow(
                            label: 'رقم الجوال',
                            value: unit.tenantPhone,
                            trailingIcon: Icons.phone_outlined,
                            colors: colors,
                            controller: bloc.tenantPhoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 16.height),

                  // ── Action buttons ────────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () => bloc.add(const UnitDetailsSaved()),
                          text: 'حفظ التعديلات',
                          isOutline: true,
                          isLoading: state.saveStatus == RequestStatus.loading,
                        ),
                      ),
                      SizedBox(width: 10.width),
                      Expanded(
                        child: AppButton(
                          onTap: () =>
                              bloc.add(const UnitDetailsSentToBroker()),
                          text: 'ارسال الى وسيط عقاري',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.height),

                  // ── Expenses ──────────────────────────────────────────────
                  UnitExpensesSection(
                    expenses: unit.expenses,
                    bloc: bloc,
                    colors: colors,
                  ),
                ],
              ),
            );
          },
        ),
        ),  // closes BlocBuilder<UnitDetailsBloc>
      ),
    );
  }

  void _confirmDelete(BuildContext context, UnitDetailsBloc bloc) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف الملف العقاري'),
        content: const Text('هل أنت متأكد من حذف هذا الملف؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(const UnitDetailsDeleted());
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
