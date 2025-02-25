import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_siya/post.dart';
import 'package:task_siya/screens/bloc/top_post_state.dart';
import 'top_post_event.dart';

class TopPostBloc extends Bloc<TopPostEvent, TopPostState> {
  TopPostBloc() : super(TopPostLoading()) {
    on<FetchTopPosts>(_onFetchTopPosts); // Register event handler
  }

  Future<void> _onFetchTopPosts(
      FetchTopPosts event, Emitter<TopPostState> emit) async {
    emit(TopPostLoading());

    try {
      final topPostIdsResponse = await http.get(
        Uri.parse(
            'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'),
      );

      if (topPostIdsResponse.statusCode == 200) {
        final topPostIds = List<int>.from(json.decode(topPostIdsResponse.body));

        List<Post> posts = [];

        for (var postId in topPostIds.take(10)) {
          final postResponse = await http.get(
            Uri.parse(
                'https://hacker-news.firebaseio.com/v0/item/$postId.json?print=pretty'),
          );

          if (postResponse.statusCode == 200) {
            final postJson = json.decode(postResponse.body);
            final post = Post.fromJson(postJson);
            posts.add(post);
          }
        }

        emit(TopPostLoaded(posts: posts));
      } else {
        emit(TopPostError(message: 'Failed to load posts'));
      }
    } catch (e) {
      emit(TopPostError(message: 'Failed to fetch data'));
    }
  }
}
