part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState({
    this.isDoneSplash = false,
    this.isOnboardingCompleted = false,
    this.isHaveToken = false,
    this.isGuest = false,
    this.role = '',
  });
  final bool isDoneSplash;
  final bool isOnboardingCompleted;
  final bool isHaveToken;
  final bool isGuest;
  final String role;
  @override
  List<Object> get props => [
    isDoneSplash,
    isOnboardingCompleted,
    isHaveToken,
    isGuest,
    role,
  ];
  SplashState copyWith({
    bool? isDoneSplash,
    bool? isOnboardingCompleted,
    bool? isHaveToken,
    bool? isGuest,
    String? role,
  }) {
    return SplashState(
      isDoneSplash: isDoneSplash ?? this.isDoneSplash,
      isHaveToken: isHaveToken ?? this.isHaveToken,
      isGuest: isGuest ?? this.isGuest,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      role: role ?? this.role,
    );
  }
}
