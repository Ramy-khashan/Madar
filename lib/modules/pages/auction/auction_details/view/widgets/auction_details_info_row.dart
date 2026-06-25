
part of 'auction_details_content_widget.dart';
class AuctionDetailsInfoRow extends StatelessWidget {
  const AuctionDetailsInfoRow({
    super.key,
    required this.label,
    required this.colors,
    this.value,
    this.valueColor,
    this.customValue,
    this.isHighestBid = false,
  });

  final String label;
  final String? value;
  final Color? valueColor;
  final Widget? customValue;
  final AppThemeColors colors;
  final bool isHighestBid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.width),
      padding: EdgeInsets.symmetric(vertical: 5.height, horizontal: 8.width),
      decoration: BoxDecoration(
        color: isHighestBid
            ? AppThemeColors.of(context).primaryBrand.withValues(alpha: 0.1)
            : AppThemeColors.of(context).borderColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.radius),
        border: isHighestBid
            ? Border.all(
                color: AppThemeColors.of(
                  context,
                ).primaryBrand.withValues(alpha: 0.2),
              )
            : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appFont,
                    color: colors.textFieldTitle,
                  ),
                ),
                if (customValue != null)
                  customValue!
                else
                  Text(
                    value ?? '',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontFamily: AppConstant.appHeaderFont,
                      fontWeight: FontWeight.w600,
                      color: valueColor ?? colors.textFieldTitle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
