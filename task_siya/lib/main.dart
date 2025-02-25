import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_siya/screens/bloc/top_post_bloc.dart';
import 'package:task_siya/screens/bloc/top_post_event.dart';
import 'package:task_siya/screens/bloc/top_post_state.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News Siya\'s Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => TopPostBloc()..add(FetchTopPosts()),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hacker News Siya\'s Task')),
      body: BlocBuilder<TopPostBloc, TopPostState>(
        builder: (context, state) {
          if (state is TopPostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TopPostError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is TopPostLoaded) {
            final posts = state.posts;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      post.title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: post.url.isNotEmpty
                        ? GestureDetector(
                            onTap: () async {
                             
                            },
                            child: Text(
                              post.url,
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        : Text("No URL Available"),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No Data available.'));
          }
        },
      ),
    );
  }
}
