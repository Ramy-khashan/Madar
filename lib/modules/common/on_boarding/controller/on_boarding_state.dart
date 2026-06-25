part of 'on_boarding_bloc.dart';

  class OnBoardingState extends Equatable {
  const OnBoardingState({
    this.currentPage = 0,
  });
  final int currentPage ;
  @override
  List<Object> get props => [
    currentPage,
  ];
  OnBoardingState copyWith({
    int? currentPage,
  }) {
    return OnBoardingState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

 