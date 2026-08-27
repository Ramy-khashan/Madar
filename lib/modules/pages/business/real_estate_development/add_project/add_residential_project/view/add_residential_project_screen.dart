import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/add_residential_project_bloc.dart';
import 'widgets/add_residential_project_view.dart';

class AddResidentialProjectScreen extends StatelessWidget {
  const AddResidentialProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddResidentialProjectBloc(),
      child: const AddResidentialProjectView(),
    );
  }
}
