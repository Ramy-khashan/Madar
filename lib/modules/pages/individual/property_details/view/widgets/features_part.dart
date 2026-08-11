import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';

class PropertyFeaturesWidget extends StatelessWidget {
  final Map<String, bool>? features;

  const PropertyFeaturesWidget({Key? key, this.features}) : super(key: key);

  Map<String, List<Map<String, String>>> get _categorizedFeatures => {
    AppStrings.featureCategoryBasicServices: [
      {'key': 'hasElectricity', 'title': AppStrings.featureElectricity},
      {'key': 'hasSewage', 'title': AppStrings.featureSewage},
      {'key': 'hasWater', 'title': AppStrings.featureWater},
      {'key': 'hasFence', 'title': AppStrings.featureFence},
      {'key': 'hasIrrigation', 'title': AppStrings.featureIrrigation},
      {'key': 'hasInternet', 'title': AppStrings.featureInternet},
    ],
    AppStrings.featureCategoryInterior: [
      {'key': 'hasCentralAC', 'title': AppStrings.featureCentralAc},
      {'key': 'hasElevator', 'title': AppStrings.featureElevator},
      {'key': 'hasMaidRoom', 'title': AppStrings.featureMaidRoom},
      {'key': 'hasTwoEntrances', 'title': AppStrings.featureTwoEntrances},
      {'key': 'hasDriverRoom', 'title': AppStrings.featureDriverRoom},
      {'key': 'hasBasement', 'title': AppStrings.featureBasement},
      {'key': 'hasRoof', 'title': AppStrings.featureRoof},
      {'key': 'hasWarehouse', 'title': AppStrings.featureWarehouse},
    ],
    AppStrings.featureCategoryExteriorSecurity: [
      {'key': 'hasPool', 'title': AppStrings.featurePool},
      {'key': 'hasWaterWell', 'title': AppStrings.featureWaterWell},
      {'key': 'hasCctv', 'title': AppStrings.featureCctv},
      {'key': 'hasElectronicGate', 'title': AppStrings.featureElectronicGate},
      {'key': 'hasGarden', 'title': AppStrings.featureGarden},
      {'key': 'hasHealthClub', 'title': AppStrings.featureHealthClub},
      {'key': 'hasGuard', 'title': AppStrings.featureGuard},
    ],
  };

  @override
  Widget build(BuildContext context) {
    print('Features: $features');
    
    // Check if features map is null or empty
    if (features == null || features!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Check if there are any true features
    final hasAnyFeatures = features!.values.any((value) => value == true);
    if (!hasAnyFeatures) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'المميزات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ),

        _buildFeatureCard([
          _buildCategorySection(
            'الخدمات الأساسية',
            _categorizedFeatures['الخدمات الأساسية']!,
          ),
          _buildCategorySection(
            'المميزات الداخلية',
            _categorizedFeatures['المميزات الداخلية']!,
          ),
        ]),

        const SizedBox(height: 12),

        _buildFeatureCard([
          
          _buildCategorySection(
            'المميزات الخارجية',
            _categorizedFeatures['المميزات الخارجية والأمن']!,
          ),
        ]),
      ],
    );
  }

  Widget _buildFeatureCard(List<Widget> children) {
    return 
    children.isEmpty? const SizedBox.shrink():
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((child) => Expanded(child: child)).toList(),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Map<String, String>> items) {
    final activeItems = items
        .where((item) => features?[item['key']] == true)
        .toList();

    if (activeItems.isEmpty) return const SizedBox.shrink();

    return activeItems.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 12),
              ...activeItems
                  .map((item) => _buildFeatureItem(item['title']!))
                  .toList(),
            ],
          );
  }

  Widget _buildFeatureItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, size: 18, color: Color(0xFF0F172A)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
