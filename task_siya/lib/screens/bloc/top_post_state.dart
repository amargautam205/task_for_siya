import 'package:task_siya/post.dart';

abstract class TopPostState {}

class TopPostLoading extends TopPostState {}

class TopPostLoaded extends TopPostState {
  final List<Post> posts;

  TopPostLoaded({required this.posts});
}

class TopPostError extends TopPostState {
  final String message;

  TopPostError({required this.message});
}
