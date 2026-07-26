part of '../notification_screen.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item, required this.onTap});

  final NotificationModel? item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: (item != null && !(item!.isRead ?? true))
            ? colors.primaryBrand.withValues(alpha: 0.06)
            : Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.width,
              height: 48.width,
              decoration: BoxDecoration(
                color: colors.borderColor.withValues(
                  alpha: item != null && !(item!.isRead ?? true) ? 0.85 : 0.3,
                ),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                CupertinoIcons.bell,
                color: colors.primaryBrand,
                size: 22.width,
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          item?.title ?? 'Notification Title',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: item?.isRead ?? false
                                ? FontWeight.w500
                                : FontWeight.w700,
                            fontSize: context.responsiveFontScale(15),
                            fontFamily: 'app-header-font',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.width),
                      Text(
                        item?.createdAt == null
                            ? 'Date Time'
                            : DateTimeHandler.formatDate(item!.createdAt!),
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: context.responsiveFontScale(11),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.height),
                  Text(
                    item?.body ?? 'Notification Body',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: context.responsiveFontScale(13),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (item != null && !(item!.isRead ?? true))
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 4.height,
                  start: 8.width,
                ),
                child: CircleAvatar(
                  radius: 5.width,
                  backgroundColor: colors.primaryBrand,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
