import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeAccountCubit extends Cubit<bool> {
  ChangeAccountCubit() : super(false);

  void setLoading(bool value) => emit(value);
}
