import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String name;
  final String accountType;
  final String location;

  const UserProfileModel({
    required this.name,
    required this.accountType,
    required this.location,
  });

  @override
  List<Object?> get props => [name, accountType, location];
}
