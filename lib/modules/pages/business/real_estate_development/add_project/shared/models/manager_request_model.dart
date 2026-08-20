import 'package:equatable/equatable.dart';

class ManagerRequestModel extends Equatable {
  const ManagerRequestModel({
    required this.fullName,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String phone;
  final String password;

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'phone': phone, 'password': password};
  }

  @override
  List<Object?> get props => [fullName, phone, password];
}
