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
      margin: EdgeInsets.only(bottom: 210.height ),
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
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: colors.primaryBrand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.radius),
                ),
                child:  ImageItem(broker.imageUrl, width: 48.width, height: 48.width, fit: BoxFit.cover),
              ),
              SizedBox(width: 10.width),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
