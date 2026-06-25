import 'package:flutter/material.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/net_profit_loss_bloc.dart';

class NetProfitLossActionsWidget extends StatelessWidget {
  const NetProfitLossActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetProfitLossBloc, NetProfitLossState>(
      buildWhen: (p, c) => p.exportStatus != c.exportStatus,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
          child: Column(
            children: [
              AppButton(onTap: () {}, text: AppStrings.downloadPdf),
              SizedBox(height: 12.height),

              AppButton(onTap: () {}, text: AppStrings.exportExcel,isOutline: true,),
            ],
          ),
        );
      },
    );
  }
}
