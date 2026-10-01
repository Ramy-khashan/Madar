import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountState {
  const DeleteAccountState({this.selectedReason = 0, this.isDeleting = false});

  final int selectedReason;
  final bool isDeleting;

  DeleteAccountState copyWith({int? selectedReason, bool? isDeleting}) {
    return DeleteAccountState(
      selectedReason: selectedReason ?? this.selectedReason,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }
}

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(const DeleteAccountState());

  void selectReason(int value) {
    if (state.isDeleting) return;
    emit(state.copyWith(selectedReason: value));
  }

  void setDeleting(bool value) => emit(state.copyWith(isDeleting: value));
}
