part of 'splash_bloc.dart';

class SplashState extends Equatable {
  const SplashState({
    this.isDoneSplash = false,
    this.isOnboardingCompleted = false,
    this.isHaveToken = false,
    this.role = "",
  });
  final bool isDoneSplash;
  final bool isOnboardingCompleted;
  final bool isHaveToken;
  final String role;
  @override
  List<Object> get props => [isDoneSplash, isOnboardingCompleted, isHaveToken, role];
  SplashState copyWith({
    bool? isDoneSplash,
    bool? isOnboardingCompleted,
    bool? isHaveToken,
    String? role,
  }) {
    return SplashState(
      isDoneSplash: isDoneSplash ?? this.isDoneSplash,
      isHaveToken: isHaveToken ?? this.isHaveToken,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      role: role ?? this.role,
    );
  }
}
