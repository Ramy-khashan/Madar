part of 'project_list_item_widget.dart';

class PropertyDevelopmentStatus extends StatelessWidget {
  const PropertyDevelopmentStatus({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: AppConstant.getStatusColor(status).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.radius),
        border: Border.all(
          color: AppConstant.getStatusColor(status).withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        status.trans,
        style: TextStyle(
          fontSize: context.responsiveFontScale(14),
          fontWeight: FontWeight.w600,
          fontFamily: AppConstant.appFont,
          color: AppConstant.getStatusColor(status),
        ),
      ),
    );
  }
}
