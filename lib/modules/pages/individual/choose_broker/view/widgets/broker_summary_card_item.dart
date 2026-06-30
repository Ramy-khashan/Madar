part of 'broker_details_content_widget.dart';

class BrokerSummaryCard extends StatelessWidget {
  const BrokerSummaryCard({
    super.key,
    required this.broker,
    required this.colors,
  });

  final BrokerModel broker;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 210.height),
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 52.width,
                height: 52.width,
                decoration: BoxDecoration(
                  color: colors.primaryBrand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.radius),
                ),
                child: const ImageItem(AppImages.agentImage),
              ),
              SizedBox(width: 10.width),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            broker.name,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textFieldTitle,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.width),
                        const ImageItem(AppImages.secureIcon),
                      ],
                    ),
                    SizedBox(height: 4.height),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14.width, color: AppColors.rate),
                         SizedBox(width: 2.width),

                        Text(
                          ' ${broker.rating} ',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontFamily: AppConstant.appHeaderFont,
                            fontWeight: FontWeight.w700,
                            color: colors.textFieldTitle,
                          ),
                        ),
                       
                        Text(
                          '(${broker.reviewsCount})',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textSecondary,
                          ),
                        ),
                       
                          Text(
                          '  •  ',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: context.responsiveFontScale(14),
                          ),
                        ),
                         Text(
                          '${broker.propertiesCount} ${AppStrings.propertiesCountSuffix}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textSecondary,
                          ),
                        ),
                      
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.height),

          Text(
            '${AppStrings.licensePrefix}: ${broker.licenseNumber}',
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w600,
              color: colors.textSecondary.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 10.height),

          // SizedBox(height: 6.height),
          // AgentDetailsRow(
          //   icon: AppImages.experienceIcon,
          //   text:
          //       '${AppStrings.experiencePrefix} ${broker.experienceYears} ${AppStrings.experienceSuffix}',
          //   colors: colors,
          // ),
          // SizedBox(height: 6.height),
          // AgentDetailsRow(
          //   icon: AppImages.occupancyIcon,
          //   text: '${AppStrings.commissionPrefix} ${broker.commissionPercent}%',
          //   colors: colors,
          // ),
        ],
      ),
    );
  }
}
