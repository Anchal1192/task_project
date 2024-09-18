
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/bloc.dart';
import '../Bloc/event_bloc.dart';
import '../Bloc/state_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: const Text('Posts',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),backgroundColor: Colors.purple,centerTitle: true,),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),]
                    ),
                    child: ListTile(
                      title: Text(post.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      subtitle: Text(post.body),
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text(post.title),
                //   subtitle: Text(post.body),
                // );
              },
            );
          } else if (state is PostError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostBloc>().add(FetchPosts());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}