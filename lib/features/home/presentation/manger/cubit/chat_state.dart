part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatCreated extends ChatState {}

class ChatError extends ChatState {
  final String error;
  ChatError({required this.error});
}