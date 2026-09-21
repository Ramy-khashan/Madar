import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class AddPropertyPlacesSearchField extends StatefulWidget {
  const AddPropertyPlacesSearchField({super.key});

  @override
  State<AddPropertyPlacesSearchField> createState() =>
      _AddPropertyPlacesSearchFieldState();
}

class _AddPropertyPlacesSearchFieldState
    extends State<AddPropertyPlacesSearchField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final bloc = AddPropertyBloc.get(context);
    if (value.trim().length < 2) {
      bloc.add(const SearchPlacesEvent(''));
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      AddPropertyBloc.get(context).add(SearchPlacesEvent(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return Column(
      children: [
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
          buildWhen: (prev, curr) =>
              prev.isSearchingPlaces != curr.isSearchingPlaces,
          builder: (context, state) {
            return AppTextField(
              controller: bloc.locationSearchController,
              hint: AppStrings.searchNeighborhoodHint,
              prefixImage: AppImages.searchIcon,
              textInputAction: TextInputAction.search,
              onChanged: _onChanged,
              onSubmitted: (value) {
                _debounce?.cancel();
                AddPropertyBloc.get(context).add(SearchPlacesEvent(value));
              },
              suffixIconWidget: state.isSearchingPlaces
                  ? Padding(
                      padding: EdgeInsets.all(12.width),
                      child: SizedBox(
                        width: 16.width,
                        height: 16.width,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: tc.primaryBrand,
                        ),
                      ),
                    )
                  : null,
            );
          },
        ),
        BlocBuilder<AddPropertyBloc, AddPropertyState>(
          buildWhen: (prev, curr) =>
              prev.placePredictions != curr.placePredictions,
          builder: (context, state) {
            if (state.placePredictions.isEmpty) {
              return const SizedBox.shrink();
            }
            return Container(
              margin: EdgeInsets.only(top: 8.height),
              constraints: BoxConstraints(maxHeight: 240.height),
              decoration: BoxDecoration(
                color: tc.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: tc.borderColor),
              ),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 4.height),
                shrinkWrap: true,
                itemCount: state.placePredictions.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  color: tc.borderColor,
                ),
                itemBuilder: (context, index) {
                  final prediction = state.placePredictions[index];
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: tc.primaryBrand,
                    ),
                    title: Text(
                      prediction.primaryText,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        fontWeight: FontWeight.w600,
                        color: tc.textPrimary,
                      ),
                    ),
                    subtitle: prediction.secondaryText.isEmpty
                        ? null
                        : Text(
                            prediction.secondaryText,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(11),
                              color: tc.textSecondary,
                            ),
                          ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      bloc.add(SelectPlaceEvent(prediction));
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
