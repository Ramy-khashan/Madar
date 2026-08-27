import 'package:flutter/material.dart';

import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class AddPropertyStepButtons extends StatelessWidget {
  const AddPropertyStepButtons({
    super.key,
    this.showBack = true,
    this.nextFlex = 1,
    this.nextLabel,
    this.onNext,
  });

  final bool showBack;
  final int nextFlex;
  final String? nextLabel;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Row(
        children: [
          if (showBack) ...[
            Expanded(
              child: AppButton(
                text: AppStrings.back,
                isOutline: true,
                onTap: () =>
                    AddPropertyBloc.get(context).add(const PreviousStepEvent()),
              ),
            ),
            12.width.toSizedBox,
          ],
          Expanded(
            flex: nextFlex,
            child: AppButton(
              text: nextLabel ?? AppStrings.next,
              onTap:
                  onNext ??
                  () => AddPropertyBloc.get(context).add(const NextStepEvent()),
            ),
          ),
        ],
      ),
    );
  }
}
