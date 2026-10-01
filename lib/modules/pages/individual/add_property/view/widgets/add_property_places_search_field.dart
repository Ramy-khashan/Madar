import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'places_search_cubit.dart';

class AddPropertyPlacesSearchField extends StatelessWidget {
  const AddPropertyPlacesSearchField({super.key});

  void _onChanged(BuildContext context, String value) {
    final search = context.read<PlacesSearchCubit>();
    search.cancel();
    final bloc = AddPropertyBloc.get(context);
    if (value.trim().length < 2) {
      bloc.add(const SearchPlacesEvent(''));
      return;
    }
    search.schedule(() {
      if (!context.mounted) return;
      AddPropertyBloc.get(context).add(SearchPlacesEvent(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return BlocProvider(
      create: (_) => PlacesSearchCubit(),
      child: Builder(
        builder: (context) {
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
                    onChanged: (value) => _onChanged(context, value),
                    onSubmitted: (value) {
                      context.read<PlacesSearchCubit>().cancel();
                      AddPropertyBloc.get(
                        context,
                      ).add(SearchPlacesEvent(value));
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
                      separatorBuilder: (_, _) =>
                          Divider(height: 1, color: tc.borderColor),
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
        },
      ),
    );
  }
}
