part of 'choose_account_bloc.dart';

sealed class ChooseAccountState extends Equatable {
  const ChooseAccountState();

  @override
  List<Object> get props => [];
}

final class ChooseAccountInitial extends ChooseAccountState {
  final int selectedIndex;
  const ChooseAccountInitial({this.selectedIndex = -1});

  @override
  List<Object> get props => [selectedIndex];

  ChooseAccountInitial copyWith({int? selectedIndex}) =>
      ChooseAccountInitial(selectedIndex: selectedIndex ?? this.selectedIndex);
}
