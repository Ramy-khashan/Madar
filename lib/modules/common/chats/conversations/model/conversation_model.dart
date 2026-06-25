import 'package:equatable/equatable.dart';

class ConversationModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String initial;
  final String imageUrl;
  final int unreadCount;
  final bool isOnline;

  const ConversationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.initial,
    required this.imageUrl,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  @override
  List<Object?> get props =>
      [id, title, subtitle, time, initial, unreadCount, isOnline, imageUrl];
}
