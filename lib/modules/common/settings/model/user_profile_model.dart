import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String name;
  final String phone;
  final String accountType;
 
  const UserProfileModel({
    required this.name,
    required this.phone,
    required this.accountType,
   });

  @override
  List<Object?> get props => [name, phone,accountType];
  UserProfileModel copyWith({
    String? name,
    String? phone,
    String? accountType,
  }) {
    return UserProfileModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      accountType: accountType ?? this.accountType,
    );
  }
}
