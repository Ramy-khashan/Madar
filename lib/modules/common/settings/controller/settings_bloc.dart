import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madar_app/core/utils/constants/app_enums.dart';

import '../../../../../config/app_controller/app_controller_bloc.dart';
 import '../../../../../core/utils/functions/service_locator.dart';
import '../../../../../core/utils/functions/translation.dart';
import '../../../../../madar_app.dart';
import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/guest_mode.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../model/user_profile_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsLoad>(_onLoad);
    on<SettingsNotificationsToggled>(_onNotificationsToggled);
    on<SettingsDarkModeToggled>(_onDarkModeToggled);
    on<SettingsLogoutRequested>(_onLogout);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsGetSavedCount>(_onGetSavedCount);
    on<SettingsGetProfile>(_onGetProfile);
    on<HandleProfileImageEvent>(_onUpdateImageInProfile);
    on<UpdateFullNameEvent>(_updateFullName);
    on<UpdatePhoneEvent>(_updatePhone);
  }

  static SettingsBloc get(BuildContext context) => context.read<SettingsBloc>();

  void _onLoad(SettingsLoad event, Emitter<SettingsState> emit) {
    final isDark = sl<AppControllerBloc>().state.isDark;
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(
          notificationsEnabled: true,
          selectedLanguage: MadarApp.navigatorKey.currentContext != null
              ? locale(MadarApp.navigatorKey.currentContext!).languageCode
              : 'ar',
          darkModeEnabled: isDark,
          loadingProfile: RequestStatus.success,
          loadingSavedItems: RequestStatus.success,
          savedItem: 0,
          profile: UserProfileModel(
            name: AppStrings.guestUserName,
            phone: '—',
            accountType: AppConstant.individual,
          ),
        ),
      );
      return;
    }
    add(const SettingsGetSavedCount());
    add(const SettingsGetProfile());
    emit(
      state.copyWith(
        notificationsEnabled: true,
        selectedLanguage: MadarApp.navigatorKey.currentContext != null
            ? locale(MadarApp.navigatorKey.currentContext!).languageCode
            : 'ar',
        darkModeEnabled: isDark,
      ),
    );
  }

  void _onNotificationsToggled(
    SettingsNotificationsToggled event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  void _onDarkModeToggled(
    SettingsDarkModeToggled event,
    Emitter<SettingsState> emit,
  ) {
    sl<AppControllerBloc>().add(const AppControllerThemeToggled());
    emit(state.copyWith(darkModeEnabled: !state.darkModeEnabled));
  }

  void _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) {
    final label = event.langCode == 'ar' ? 'اللغة العربية' : 'English';
    emit(state.copyWith(selectedLanguage: label));
  }

  void _onLogout(SettingsLogoutRequested event, Emitter<SettingsState> emit) {}

  Future<void> _onGetSavedCount(
    SettingsGetSavedCount event,
    Emitter<SettingsState> emit,
  ) async {
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(savedItem: 0, loadingSavedItems: RequestStatus.success),
      );
      return;
    }
    try {
      emit(state.copyWith(loadingSavedItems: RequestStatus.loading));
      final response = await sl.get<ApiConsumer>().get(EndPoints.wishlistCount);
      await response.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              savedItem: 0,
              loadingSavedItems: RequestStatus.failed,
            ),
          );
        },
        (successResponse) {
          final count = successResponse.response['data']['count'] ?? 0;
          emit(
            state.copyWith(
              savedItem: count,
              loadingSavedItems: RequestStatus.success,
            ),
          );
        },
      );
    } catch (e) {
       emit(
        state.copyWith(savedItem: 0, loadingSavedItems: RequestStatus.failed),
      );
    }
  }

  Future<void> _onGetProfile(
    SettingsGetProfile event,
    Emitter<SettingsState> emit,
  ) async {
    if (GuestMode.isGuest) {
      return;
    }
    try {
      emit(state.copyWith(loadingProfile: RequestStatus.loading));
      final response = await sl.get<ApiConsumer>().get(EndPoints.getProfile);
      await response.fold(
        (failedResponse) {
          emit(
            state.copyWith(profile: null, loadingProfile: RequestStatus.failed),
          );
        },
        (successResponse) {
          final data = successResponse.response['data'];
          final userId =
              (data?['user_id'] ?? data?['userId'] ?? data?['id'] ?? '')
                  .toString();
          if (userId.isNotEmpty) {
            sl.get<PreferenceUtils>().setString(StorageKeys.userID, userId);
          }
          emit(
            state.copyWith(
              profile: UserProfileModel(
                name: successResponse.response['data']['fullName'] ?? '',
                phone: successResponse.response['data']['phone'] ?? '',
                accountType:
                    successResponse.response['data']['accountType'] ?? '',
              ),
              loadingProfile: RequestStatus.success,
            ),
          );
        },
      );
    } catch (e) {
       emit(state.copyWith(profile: null, loadingProfile: RequestStatus.failed));
    }
  }

  Future<void> _onUpdateImageInProfile(
    HandleProfileImageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingImageProfile: RequestStatus.loading));

      final ImagePicker imagePicker = ImagePicker();
      await imagePicker
          .pickImage(source: ImageSource.gallery)
          .then((pickedFile) async {
            if (pickedFile != null) {
              final FormData image = FormData.fromMap({
                'image': await MultipartFile.fromFile(pickedFile.path),
              });
              final response = await sl.get<ApiConsumer>().putFormData(
                EndPoints.getProfile,
                body: image,
              );
              await response.fold(
                (failedResponse) {
                  emit(
                    state.copyWith(loadingImageProfile: RequestStatus.failed),
                  );
                },
                (successResponse) {
                  sl.get<PreferenceUtils>().setString(
                    StorageKeys.image,
                    successResponse.response['data']['image'] ?? '',
                  );
                  emit(
                    state.copyWith(loadingImageProfile: RequestStatus.success),
                  );
                },
              );
            }
          })
          .onError((error, stackTrace) {
            emit(state.copyWith(loadingImageProfile: RequestStatus.failed));
          });
    } catch (e) {
      emit(state.copyWith(loadingImageProfile: RequestStatus.failed));
    }
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> _updateFullName(
    UpdateFullNameEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(updateFullNameStatus: RequestStatus.loading));

      final res = await sl.get<ApiConsumer>().put(
        EndPoints.profile,
        body: {'fullName': fullNameController.text},
      );
      res.fold(
        (failedResponse) {
          emit(state.copyWith(updateFullNameStatus: RequestStatus.failed));
        },
        (successResponse) {
          RouterHandler.pop(event.context); // Close the dialog
          emit(
            state.copyWith(
              updateFullNameStatus: RequestStatus.success,
              profile: state.profile?.copyWith(name: fullNameController.text),
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(updateFullNameStatus: RequestStatus.failed));
    }
  }

  Future<void> _updatePhone(
    UpdatePhoneEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(updatePhoneStatus: RequestStatus.loading));

      final res = await sl.get<ApiConsumer>().put(
        EndPoints.profile,
        body: {'phone': phoneController.text},
      );
      res.fold(
        (failedResponse) {
          emit(state.copyWith(updatePhoneStatus: RequestStatus.failed));
        },
        (successResponse) {
          RouterHandler.pop(event.context); // Close the dialog

          emit(
            state.copyWith(
              updatePhoneStatus: RequestStatus.success,
              profile: state.profile?.copyWith(phone: phoneController.text),
            ),
          );
        },
      );
    } catch (e) {
       emit(state.copyWith(updatePhoneStatus: RequestStatus.failed));
    }
  }
}
