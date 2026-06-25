part of '../smart_assistant_intro_screen.dart';

class ModeToggle extends StatelessWidget {
  const ModeToggle({
    super.key,
    required this.isMicMode,
    required this.onToggle,
  });

  final bool isMicMode;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 200.width,
        height: 58.height,
        decoration: BoxDecoration(
          color: AppThemeColors.of(context).backgroundPrimary,
          borderRadius: BorderRadius.circular(24.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isMicMode
                      ? AppThemeColors.of(context).primaryBrand
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24.radius),
                ),
                child: Icon(
                  Icons.mic_none_rounded,
                  color: isMicMode
                      ? AppThemeColors.of(context).onPrimary
                      : AppThemeColors.of(context).textSecondary,
                  size: 30.fontSize,
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),

                decoration: BoxDecoration(
                  color: !isMicMode
                      ? AppThemeColors.of(context).primaryBrand
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24.radius),
                ),
                child: Icon(
                  Icons.keyboard_alt_outlined,
                  color: !isMicMode
                      ? AppThemeColors.of(context).onPrimary
                      : AppThemeColors.of(context).textSecondary,
                  size: 28.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
