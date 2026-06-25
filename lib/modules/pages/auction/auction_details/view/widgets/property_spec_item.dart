part of 'auction_details_content_widget.dart';

class PropertySpecItem extends StatelessWidget {
  const PropertySpecItem({
    super.key,
    required this.icon,
    required this.value,
    required this.colors,
  });

  final IconData icon;
  final String value;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.height, top: 10.height),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20.width, color: colors.primaryBrand),
          SizedBox(width: 6.width),
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
