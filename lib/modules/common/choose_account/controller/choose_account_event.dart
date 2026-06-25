part of 'choose_account_bloc.dart';

sealed class ChooseAccountEvent extends Equatable {
  const ChooseAccountEvent();

  @override
  List<Object> get props => [];
}

final class SelectAccountEvent extends ChooseAccountEvent {
  final int index;
  const SelectAccountEvent(this.index);

  @override
  List<Object> get props => [index];
}
