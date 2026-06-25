part of '../conversations_screen.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key, required this.item, required this.onTap});

  final ConversationModel? item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 56.width,
                  height: 56.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3D63CB),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item?.initial ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.responsiveFontScale(22),
                      fontFamily: 'app-header-font',
                    ),
                  ),
                ),
                if (item?.isOnline ?? false)
                  Positioned(
                    bottom: 1,
                    left: 0,
                    child: Container(
                      width: 14.width,
                      height: 14.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2BE15D),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
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
                          item?.title ?? 'Title',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: context.responsiveFontScale(16),
                            fontFamily: 'app-header-font',
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                  SizedBox(height: 4.height),
                  Text(
                    item?.subtitle ?? 'Subtitle',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: context.responsiveFontScale(13),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.width),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item?.time ?? '00:00',
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: context.responsiveFontScale(12),
                  ),
                ),
                SizedBox(height: 4.height),
            if (item?.unreadCount != null && item!.unreadCount > 0)
              SizedBox(
                width: 28.width,
                child: CircleAvatar(
                  radius: 12.width,
                  backgroundColor:AppColors.lightSuccessColor,

                  child: Center(
                    child: Text(
                      '${item?.unreadCount ?? 0}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.responsiveFontScale(11),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              ]),
          ],
        ),
      ),
    );
  }
}
