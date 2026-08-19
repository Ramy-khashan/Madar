import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../connection/concept/end_points.dart';
import '../../connection/implementation/dio_consumer.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../model/api_model.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';
import '../../../modules/common/chats/models/chat_models.dart';

class ChatApis {
  ChatApis._();

  static Future<Either<String, AiChatReplyModel>> sendAiMessage(
    String text,
  ) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.chatAi,
        body: {'text': text},
      );
      return response.fold(Left.new, (success) {
        final data = success.response['data'];
        if (data is! Map) {
          return Left(AppStrings.somethingWentWrong);
        }
        return Right(
          AiChatReplyModel.fromJson(Map<String, dynamic>.from(data)),
        );
      });
    } catch (e) {
      printState('sendAiMessage error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, List<ChatModel>>> getMyChats() async {
    try {
      final response = await sl.get<ApiConsumer>().get(EndPoints.myChats);
      return response.fold(Left.new, (success) {
        final data = success.response['data'];
        if (data is! List) return const Right(<ChatModel>[]);
        final chats = data
            .whereType<Map>()
            .map((e) => ChatModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        ChatSession.rememberFromChats(chats);
        return Right(chats);
      });
    } catch (e) {
      printState('getMyChats error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, ChatMessageModel>> sendMessage({
    required String chatId,
    required String text,
  }) async {
    try {
      var response = await _postUrlEncoded(EndPoints.chatMessage(chatId), {
        'text': text,
      });
      if (response.isLeft()) {
        response = await sl.get<ApiConsumer>().post(
          EndPoints.chatMessage(chatId),
          body: {'text': text},
        );
      }
      return response.fold(Left.new, (success) {
        final data = success.response['data'];
        if (data is! Map) {
          return Left(AppStrings.somethingWentWrong);
        }
        return Right(
          ChatMessageModel.fromJson(Map<String, dynamic>.from(data)),
        );
      });
    } catch (e) {
      printState('sendMessage error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, ChatModel>> createPrivateChat(
    String receiverId,
  ) async {
    try {
      var response = await sl.get<ApiConsumer>().post(
        EndPoints.chatPrivate,
        body: {'receiverId': receiverId},
      );
      if (response.isLeft()) {
        response = await _postUrlEncoded(EndPoints.chatPrivate, {
          'receiverId': receiverId,
        });
      }
      return response.fold(Left.new, (success) {
        final data = success.response['data'];
        if (data is! Map) {
          return Left(AppStrings.somethingWentWrong);
        }
        return Right(ChatModel.fromJson(Map<String, dynamic>.from(data)));
      });
    } catch (e) {
      printState('createPrivateChat error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, ApiModel>> _postUrlEncoded(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await sl.get<Dio>().post(
        path,
        data: body,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return (sl.get<ApiConsumer>() as DioConsumer).handleResponseStatus(
        response,
      );
    } on DioException catch (e) {
      printState('urlencoded post error: $e');
      return Left(e.message ?? AppStrings.somethingWentWrong);
    } catch (e) {
      printState('urlencoded post unexpected: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }
}
