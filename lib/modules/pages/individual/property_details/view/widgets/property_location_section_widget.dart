import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_details_buyer_model.dart';
import '../../model/property_details_model.dart';

class PropertyLocationSectionWidget extends StatelessWidget {
  const PropertyLocationSectionWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final latLng = LatLng(
      property?.location?.latitude ?? 0,
      property?.location?.longitude ?? 0,
    );
    final nearby = property?.location?.nearby ?? [];
    final location =
        (property?.location?.city ?? '') +
        (property?.location?.district != null
            ? ', ${property?.location?.district}'
            : '') +
        (property?.location?.street != null
            ? ', ${property?.location?.street}'
            : '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section title ───────────────────────────────────────────────
        Text(
          AppStrings.locationOnMap,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
        SizedBox(height: 12.height),

        // ── Map ─────────────────────────────────────────────────────────
        
          ClipRRect(
            borderRadius: BorderRadius.circular(16.radius),
            child: SizedBox(
              height: 160.height,
              child: GoogleMap(
                onTap: (_) {
                  //TODO: Implement navigation to full screen map with the property location
                },
                initialCameraPosition: CameraPosition(target: latLng, zoom: 15),
                markers: {
                  Marker(
                    markerId: const MarkerId('property'),
                    position: latLng,
                  ),
                },
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                myLocationButtonEnabled: false,
                liteModeEnabled: true,
              ),
            ),
          ),

        SizedBox(height: 12.height),

        // ── Location row ────────────────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.width,
            vertical: 10.height,
          ),
          decoration: BoxDecoration(
            color: colors.backgroundSecondary,
            borderRadius: BorderRadius.circular(12.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: 18.width,
                color: colors.primaryBrand,
              ),
              SizedBox(width: 8.width),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(width: 8.width),
              Icon(Icons.near_me, size: 18.width, color: colors.primaryBrand),
            ],
          ),
        ),

        // ── Nearby places ───────────────────────────────────────────────
        if (nearby.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 16.height),
            decoration: BoxDecoration(
              color: colors.hoverColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.radius),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.width,
              vertical: 10.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.nearbyPlaces,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
                Divider(height: 20.height),
                ...nearby.map(
                  (place) => Padding(
                    padding: EdgeInsets.only(bottom: 8.height),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          place.toString(),
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textFieldTitle,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                        Text(
                          place.toString(),
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.primaryBrand,
                            fontFamily: AppConstant.appFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
