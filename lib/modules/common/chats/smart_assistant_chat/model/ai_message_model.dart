import 'package:equatable/equatable.dart';

class AiMessageModel extends Equatable {
  final String id;
  final String text;
  final bool isUser;

  const AiMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
  });

  @override
  List<Object?> get props => [id, text, isUser];
}
