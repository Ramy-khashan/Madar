part of 'insurance_info_tab_widget.dart';

class InsuranceCoverageDetailsSection extends StatelessWidget {
  const InsuranceCoverageDetailsSection({
    super.key,
    required this.risks,
    required this.colors,
  });

  final List<CoverageRiskModel> risks;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            16.width,
            16.height,
            16.width,
            12.height,
          ),
          child: Text(
            AppStrings.coverageDetailsTitle,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(16.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 10.height,
                ),
                color: colors.primaryBrand.withValues(alpha: 0.05),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        AppStrings.riskTypeHeader,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w600,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 56.width,
                      child: Text(
                        AppStrings.comprehensiveCoverageHeader,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w600,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 56.width,
                      child: Text(
                        AppStrings.basicCoverageHeader,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w600,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Table rows
              ...risks.asMap().entries.map((entry) {
                final index = entry.key;
                final risk = entry.value;
                final isLast = index == risks.length - 1;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.width,
                        vertical: 12.height,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              risk.riskName,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textFieldTitle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 56.width,
                            child: Icon(
                              risk.comprehensiveCovered
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.cancel_outlined,
                              size: 18.width,
                              color: risk.comprehensiveCovered
                                  ? AppThemeColors.of(context).primaryBrand
                                  : colors.textSecondary,
                            ),
                          ),
                          SizedBox(
                            width: 56.width,
                            child: Icon(
                              risk.basicCovered
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.cancel_outlined,
                              size: 18.width,
                              color: risk.basicCovered
                                  ? AppColors.successColor
                                  : colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1.height,
                        indent: 16.width,
                        endIndent: 16.width,
                        color: colors.borderColor,
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
