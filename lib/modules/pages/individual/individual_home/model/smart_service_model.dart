import 'package:equatable/equatable.dart';
 
class SmartServiceModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String route;

  const SmartServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon, required this.route,
  });

  @override
  List<Object?> get props => [id, title, description];
}
