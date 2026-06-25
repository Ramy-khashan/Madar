part of 'phase_details_bloc.dart';

class PhaseDetailsState extends Equatable {
  const PhaseDetailsState({
    required this.phase,
    this.isApproving = false,
  });

  final PhaseModel phase;
  final bool isApproving;

  PhaseDetailsState copyWith({
    PhaseModel? phase,
    bool? isApproving,
  }) {
    return PhaseDetailsState(
      phase: phase ?? this.phase,
      isApproving: isApproving ?? this.isApproving,
    );
  }

  @override
  List<Object?> get props => [phase, isApproving];
}
