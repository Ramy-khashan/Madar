import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String id;
  final String text;
  final bool isOutgoing;
  final String time;

  const MessageModel({
    required this.id,
    required this.text,
    required this.isOutgoing,
    required this.time,
  });

  @override
  List<Object?> get props => [id, text, isOutgoing, time];
}
