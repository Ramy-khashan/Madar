part of 'contract_details_content_widget.dart';

class ContractSummaryCard extends StatelessWidget {
  const ContractSummaryCard({super.key, required this.contract});

  final ContractDetailsModel? contract;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: AppColors.blueColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.radius),
        border: Border.all(color: AppColors.blueColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: ContractStatusBadge(
              status: contract?.status ?? 'PENDING',
              label: contract?.statusLabel,
            ),
          ),
          SizedBox(height: 10.height),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.contractIdLabel,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.primaryBrand,
                  ),
                ),
              ),
              Text(
                contract?.contractNo.isNotEmpty == true
                    ? contract!.contractNo
                    : (contract?.id ?? ''),
                style: TextStyle(
                  fontSize: context.responsiveFontScale(17),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.height),
          Row(
            children: [
              Text(
                AppStrings.descriptionLabel,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.primaryBrand,
                ),
              ),SizedBox(width: 10.width),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    contract?.propertyName ?? '',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      
                      fontWeight: FontWeight.w400,
                      fontFamily: AppConstant.appFont,
                      color: colors.textFieldTitle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
