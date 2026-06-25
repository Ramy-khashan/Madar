part of 'on_boarding_bloc.dart';

sealed class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}
class OnBoardingChangePage extends OnBoardingEvent {
   final BuildContext context;
   const OnBoardingChangePage({
    required this.context,});
  @override
  List<Object> get props => [
    context,
  ];
}