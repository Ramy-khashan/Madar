class PropertyDetailsRouteArgs {
  const PropertyDetailsRouteArgs({
    required this.propertyId,
    this.brokerRequestId,
    this.adLicenseNumber,
  });

  final String propertyId;
  final String? brokerRequestId;
  final String? adLicenseNumber;

  bool get isBrokerRequest => (brokerRequestId ?? '').isNotEmpty;

  static PropertyDetailsRouteArgs fromExtra(Object? extra) {
    if (extra is PropertyDetailsRouteArgs) return extra;
    if (extra is Map) {
      return PropertyDetailsRouteArgs(
        propertyId: '${extra['propertyId'] ?? extra['id'] ?? ''}',
        brokerRequestId: extra['requestId']?.toString(),
        adLicenseNumber: extra['adLicenseNumber']?.toString(),
      );
    }
    return PropertyDetailsRouteArgs(propertyId: extra?.toString() ?? '');
  }
}
