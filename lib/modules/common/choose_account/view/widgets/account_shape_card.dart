part of '../choose_account_screen.dart';

class AccountShapeCard extends StatelessWidget {
  const AccountShapeCard({
    super.key,
    required this.account,
    required this.isSelected,
    required this.onTap,
  });

  final AccountModel account;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final brandColor = colors.primaryBrand;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? brandColor
                : colors.textSecondary.withValues(alpha: .3),
            width: isSelected ? 1.8 : 1.3,
          ),
          borderRadius: BorderRadius.circular(16),
          color: colors.cardBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.width),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 52.width,
                    height: 52.width,
                    decoration: BoxDecoration(
                      color: brandColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: ImageItem(
                      account.image,
                      width: 26.width,
                      height: 26.width,
                      color: colors.onPrimary,
                    ),
                  ),
                  SizedBox(width: 12.width),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                account.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(16),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstant.appFont,
                                  color: colors.textFieldTitle,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.width),
                            if (account.accountType != AppConstant.developer)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.width,
                                  vertical: 3.height,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.textSecondary.withValues(
                                    alpha: .12,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  account.badge,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(locale(context).languageCode=='ar'?10:8),
                                    color: colors.textSecondary,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4.height),

                        Text(
                          account.accountType == AppConstant.developer
                              ? account.badge
                              : account.description,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.width),

                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? brandColor
                            : colors.textSecondary.withValues(alpha: .4),
                        width: 2,
                      ),
                      color: isSelected ? brandColor : Colors.transparent,
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                left: 12.width,
                right: 12.width,
                bottom: 12.height,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 12.height,
              ),
              decoration: BoxDecoration(
                color: colors.textSecondary.withValues(alpha: .07),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: account.features.asMap().entries.map((entry) {
                  final isLast = entry.key == account.features.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 8.height),
                    child: Row(
                      children: [
                        Icon(Icons.check, size: 16, color: brandColor),
                        SizedBox(width: 8.width),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(12),
                              color: colors.textPrimary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
