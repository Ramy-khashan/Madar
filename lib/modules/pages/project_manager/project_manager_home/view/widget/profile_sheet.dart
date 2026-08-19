import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../../common/settings/controller/settings_bloc.dart';
import '../../../../../common/settings/view/widgets/language_bottom_sheet_widget.dart';
import '../../../../../common/settings/view/widgets/logout_dialog.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key, required this.userName});
  final String userName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Container(
                          width: 50.width,
                          height: 50.width,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE0E0E0),
                          ),
                          child: const Center(child: Icon(Icons.person)),
                        ),
                        const SizedBox(width: 14),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF17233D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(9),
                            ),
                            onTap: () {
                              showLanguageBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 42.width,
                                    height: 42.width,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD9DCE1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      Icons.language,
                                      size: 26.width,
                                      color: const Color(0xFF263238),
                                    ),
                                  ),
                                  SizedBox(width: 10.width),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.language,
                                          style: TextStyle(
                                            fontSize: context
                                                .responsiveFontScale(16),
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF222222),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          locale(context).languageCode.trans,
                                          style: TextStyle(
                                            fontSize: context
                                                .responsiveFontScale(13),
                                            color: const Color(0xFF8B8B8B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20.width,
                                    color: const Color(0xFF263238),
                                  ),

                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.width),
                            child: const Divider(
                              height: 1,
                              thickness: .8,
                              color: Color(0xFFE5E5E5),
                            ),
                          ),

                          InkWell(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(9),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return const LogoutDialog();
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.width,
                                vertical: 14.height,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFDCDC),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const ImageItem(AppImages.logout),
                                  ),

                                  SizedBox(width: 10.width),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.logout,
                                          style: TextStyle(
                                            fontSize: context
                                                .responsiveFontScale(16),
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFFF4545),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          AppStrings.managerLogoutHint,
                                          style: TextStyle(
                                            fontSize: context
                                                .responsiveFontScale(13),
                                            color: const Color(0xFF8B8B8B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 8.width),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20.width,
                                    color: const Color(0xFF263238),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
